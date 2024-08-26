import {
  Injectable,
  Logger,
  UnauthorizedException,
  BadRequestException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from './entities/user.entity';
import { JwtPayload } from './interfaces/jwt-payload.interface';
import { CreateUserDto } from './dto/create-user.dto';
import { LoginUserDto } from './dto/login-user.dto';
import handleDbExceptions from 'src/common/exceptions/error.db.exception';
import { ErrorCode } from 'src/common/glob/error';
import { PasswordUserDto } from './dto/password-user.dto';
import { DEFAULT_RESULT } from '../common/constants/response';
import { I18nContext, I18nService } from 'nestjs-i18n';

@Injectable()
export class AuthService {
  private readonly logger = new Logger(AuthService.name);

  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,

    private readonly jwtService: JwtService,

    private readonly i18n: I18nService,
  ) {}

  async register(createUserDto: CreateUserDto) {
    const { password, ...userData } = createUserDto;
    const verification = await this.userRepository
      .createQueryBuilder('us')
      .andWhere('(us.email = :email OR us.phone = :phone)')
      .setParameters({ email: userData.email, phone: userData.phone })
      .getOne();

    if (verification) {
      if (verification['email'] === userData.email) {
        throw new BadRequestException({ codeError: ErrorCode.EMAILUNIQUE });
      } else if (verification['phone'] === userData.phone) {
        throw new BadRequestException({ codeError: ErrorCode.PHONEUNIQUE });
      } else {
        throw new BadRequestException({ codeError: ErrorCode.UNKNOWN });
      }
    }

    try {
      const user = this.userRepository.create({
        ...userData,
        password: bcrypt.hashSync(password, 3),
      });

      await this.userRepository.save(user);

      delete user.password;

      return {
        user: {
          ...user,
          token: this._getJwtToken({
            id: user.id,
            email: user.email,
          }),
        },
        message: 'exito',
        result: DEFAULT_RESULT.result,
      };
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

  async login(loginUserDto: LoginUserDto) {
    const { password, email } = loginUserDto;
    const user = await this.userRepository.findOne({
      select: {
        id: true,
        fistName: true,
        paternalName: true,
        maternalName: true,
        email: true,
        password: true,
        phone: null,
        cellphone: null,
        image: true,
        roles: true,
      },
      where: { email },
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

  private _getJwtToken(jwtpayload: JwtPayload) {
    return this.jwtService.sign(jwtpayload);
  }
}
