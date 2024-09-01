import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { Repository } from 'typeorm';
import handleDbExceptions from '../../common/exceptions/error.db.exception';
import { User } from '../../auth/entities/user.entity';
import { PAGINATION_DEFAULT_VALUES } from '../../common/constants/pagination';
import { DEFAULT_RESULT } from '../../common/constants/response';
import { getOrderBy } from '../../common/helpers/pagination';
import { ProyectType } from './entities/proyectType.entity';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { CreateProyectTypeDto } from './dto/create-proyectType.dto';

@Injectable()
export class ProyectTypeService {
  private readonly logger = new Logger(ProyectTypeService.name);

  constructor(
    @InjectRepository(ProyectType)
    private readonly proyectTypeRepository: Repository<ProyectType>,

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
    const [items, total_items] = await this.proyectTypeRepository.findAndCount({
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
    const data = await this.proyectTypeRepository.findOne({
      where: { id },
    });
    return {
      data,
    };
  }

  async create(user: User, createUserTypeDto: CreateProyectTypeDto) {
    try {
      const systemDocument = await this.proyectTypeRepository.save({
        ...createUserTypeDto,
        created_by: user.id,
        updated_by: user.id,
      });

      return {
        systemDocument,
        message: this.i18n.t('messages.creationSuccess', {
          lang: I18nContext.current().lang,
        }),
      };
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

  async updated(user: User, createUserTypeDto: CreateProyectTypeDto) {
    try {
      const systemDocument = await this.proyectTypeRepository.save({
        ...createUserTypeDto,
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
    const user = await this.proyectTypeRepository.softDelete({
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

  async getProyectTypeOptions() {
    return await this.proyectTypeRepository
      .createQueryBuilder('c')
      .select('id AS value, name AS label')
      .getRawMany();
  }
}
