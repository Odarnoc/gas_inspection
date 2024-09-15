import {
  Injectable,
  Logger,
  UnauthorizedException,
  BadRequestException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { ArrayContainedBy, Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './entities/user.entity';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { CreateUserDto } from './dto/create-user.dto';
import { LoginUserDto } from './dto/login-user.dto';
import handleDbExceptions from 'src/common/exceptions/error.db.exception';
import { PasswordUserDto } from './dto/password-user.dto';
import { DEFAULT_RESULT } from '../common/constants/response';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { PAGINATION_DEFAULT_VALUES } from 'src/common/constants/pagination';
import { getOrderBy } from 'src/common/helpers/pagination';
import { UpdateUserDto } from './dto/update-user.dto';
import { ViewUserInspectorOptions } from './entities/userInspectorOptions.view.entity';
import { TypesRol } from 'src/common/glob/types';
import { ViewUserInstalatorOptions } from './entities/userInstalatorOptions.view.entity';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,

    @InjectRepository(ViewUserInspectorOptions)
    private readonly viewUserInspectorOptionsRepository: Repository<ViewUserInspectorOptions>,

    @InjectRepository(ViewUserInstalatorOptions)
    private readonly viewUserInstalatorOptionsRepository: Repository<ViewUserInstalatorOptions>,

    private readonly jwtService: JwtService,

    private readonly i18n: I18nService,
  ) {}

  async getTable({
    page,
    rowsPerPage,
    offset,
    sortBy,
    descending,
    where,
  }: PaginationCompleteDto) {
    const current = page || PAGINATION_DEFAULT_VALUES.page;
    const limit = rowsPerPage || PAGINATION_DEFAULT_VALUES.rowsPerPage;
    const skip = offset || (current - 1) * limit;
    sortBy = sortBy || PAGINATION_DEFAULT_VALUES.sortBy;
    descending = descending ?? PAGINATION_DEFAULT_VALUES.descending;
    const order = getOrderBy(sortBy, descending);
    const [items, total_items] = await this.userRepository.findAndCount({
      where,
      take: limit,
      skip,
      order,
    });
    return {
      tableData: {
        items,
        current,
        limit,
        sortBy,
        total_items,
        descending,
      },
    };
  }

  async get(id: number) {
    const data = await this.userRepository.findOne({
      where: { id },
    });
    return {
      data,
    };
  }

  async create(createUserDto: CreateUserDto) {
    const { password, ...userData } = createUserDto;
    const verification = await this.userRepository
      .createQueryBuilder('us')
      .andWhere('(us.email = :email OR us.phone = :phone)')
      .setParameters({ email: userData.email, phone: userData.phone })
      .getOne();

    if (verification) {
      if (verification['email'] === userData.email) {
        throw new BadRequestException(
          this.i18n.t('warnings.emailAlreadyExist', {
            lang: I18nContext.current().lang,
          }),
        );
      }
    }

    try {
      const user = this.userRepository.create({
        ...userData,
        roles: [userData.rol],
        password: bcrypt.hashSync(password, 3),
      });

      await this.userRepository.save(user);

      delete user.password;

      return {
        user,
        message: this.i18n.t('messages.creationSuccess', {
          lang: I18nContext.current().lang,
        }),
        result: DEFAULT_RESULT.result,
      };
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

  async updated(user: User, updateUserDto: UpdateUserDto) {
    try {
      const systemDocument = await this.userRepository.save({
        ...updateUserDto,
        roles: [updateUserDto.rol],
        updated_by: user.id,
      });
      return {
        systemDocument,
        message: this.i18n.t('messages.updatedSuccess', {
          lang: I18nContext.current().lang,
        }),
        result: DEFAULT_RESULT.result,
      };
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

  async delete(id: number) {
    const user = await this.userRepository.softDelete({
      id,
    });

    return {
      user,
      result: DEFAULT_RESULT.result,
      message: this.i18n.t('messages.deleteSuccess', {
        lang: I18nContext.current().lang,
      }),
    };
  }

  async loginWeb(loginUserDto: LoginUserDto) {
    const { password, email } = loginUserDto;
    const user = await this.userRepository.findOne({
      select: {
        id: true,
        firstName: true,
        paternalName: true,
        maternalName: true,
        email: true,
        password: true,
        phone: null,
        cellphone: null,
        image: true,
        roles: true,
      },
      where: {
        email,
        roles: ArrayContainedBy([TypesRol.admin, TypesRol.vendor]),
      },
    });

    if (!user) {
      throw new UnauthorizedException(
        this.i18n.t('warnings.invalidCredentials', {
          lang: I18nContext.current().lang,
        }),
      );
    }

    if (!bcrypt.compareSync(password, user.password)) {
      throw new UnauthorizedException(
        this.i18n.t('warnings.invalidCredentials', {
          lang: I18nContext.current().lang,
        }),
      );
    }

    delete user.password;
    return {
      ...user,
      token: this._getJwtToken({ id: user.id, email: user.email }),
    };
  }

  async loginApp(loginUserDto: LoginUserDto) {
    const { password, email } = loginUserDto;
    const user = await this.userRepository.findOne({
      select: {
        id: true,
        firstName: true,
        paternalName: true,
        maternalName: true,
        email: true,
        password: true,
        phone: null,
        cellphone: null,
        image: true,
        roles: true,
      },
      where: {
        email,
        roles: ArrayContainedBy([TypesRol.inspector, TypesRol.instalator]),
      },
    });

    if (!user) {
      throw new UnauthorizedException(
        this.i18n.t('warnings.invalidCredentials', {
          lang: I18nContext.current().lang,
        }),
      );
    }

    if (!bcrypt.compareSync(password, user.password)) {
      throw new UnauthorizedException(
        this.i18n.t('warnings.invalidCredentials', {
          lang: I18nContext.current().lang,
        }),
      );
    }

    delete user.password;
    return {
      ...user,
      token: this._getJwtToken({ id: user.id, email: user.email }),
    };
  }

  async updatePassword(user: User, passwordUserDto: PasswordUserDto) {
    const { password } = passwordUserDto;
    try {
      const userUpdate = await this.userRepository.preload({
        id: user.id,
        password: bcrypt.hashSync(password, 3),
      });

      if (userUpdate) {
        await this.userRepository.save(userUpdate);

        delete userUpdate.password;
        return {
          user: { ...userUpdate },
          result: true,
          message: 'actualizado',
        };
      }
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

  async profile(user: User) {
    return { ...user, result: true };
  }

  async getInspectorOptions() {
    return await this.viewUserInspectorOptionsRepository.find();
  }

  async getInstalatorOptions() {
    return await this.viewUserInstalatorOptionsRepository.find();
  }

  private _getJwtToken(jwtpayload: JwtPayload) {
    return this.jwtService.sign(jwtpayload);
  }
}
