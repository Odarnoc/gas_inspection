import { Inject, Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { Between, In, Repository } from 'typeorm';
import handleDbExceptions from '../../common/exceptions/error.db.exception';
import { User } from '../../auth/entities/user.entity';
import { PAGINATION_DEFAULT_VALUES } from '../../common/constants/pagination';
import { DEFAULT_RESULT } from '../../common/constants/response';
import { getOrderBy } from '../../common/helpers/pagination';
import { RequestPetition } from './entities/requestPetition.entity';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { CreateRequestPetitionDto } from './dto/requestPetition.dto';
import { StatusOrder } from 'src/common/glob/status';
import { RequestPetitionLogsService } from 'src/log/request-petition/request-petition-logs.service';
import { TypesEventLogs, TypesResultEventLogs } from 'src/common/glob/types';
import { ReportPDFDto } from 'src/pdf/request/dto/reports.dto';

@Injectable()
export class RequestPetitionService {
  private readonly logger = new Logger(RequestPetitionService.name);

  constructor(
    @InjectRepository(RequestPetition)
    private readonly requestPetitionRepository: Repository<RequestPetition>,

    @InjectRepository(User)
    private readonly userRepository: Repository<User>,

    @Inject(RequestPetitionLogsService)
    private readonly requestPetitionLogsService: RequestPetitionLogsService,

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
    const [items, total_items] =
      await this.requestPetitionRepository.findAndCount({
        relations: {
          proyectType: true,
          inspector: true,
          instalator: true,
        },
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
    const data = await this.requestPetitionRepository.findOne({
      relations: {
        proyectType: true,
        inspector: true,
        instalator: true,
      },
      where: { id },
    });
    return {
      data,
    };
  }

  async getRejected(reportPDFDto: ReportPDFDto) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        vendor: true,
        inspector: true,
        instalator: true,
      },
      where: {
        status: StatusOrder.rejected,
        rejectedDate: Between(reportPDFDto.startDate, reportPDFDto.endDate),
      },
    });
    return {
      data,
    };
  }

  async getInProgress(reportPDFDto: ReportPDFDto) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        vendor: true,
        inspector: true,
        instalator: true,
      },
      where: {
        status: In([
          StatusOrder.assigned,
          StatusOrder.inspectionAproved,
          StatusOrder.instalationAssigned,
          StatusOrder.instalationReassigned,
          StatusOrder.interrnalInspection,
          StatusOrder.observed,
        ]),
        // createdAt: Between(reportPDFDto.startDate, reportPDFDto.endDate),
      },
    });
    return {
      data,
    };
  }

  async create(user: User, createUserTypeDto: CreateRequestPetitionDto) {
    try {
      const systemDocument = await this.requestPetitionRepository.save({
        ...createUserTypeDto,
        vendor: { id: user.id },
      });

      await this.requestPetitionLogsService.createLog({
        user,
        eventType: TypesEventLogs.create,
        result: TypesResultEventLogs.success,
        log: 'Se creo un nuevo proyecto',
        extraDetails: `${systemDocument.id}`,
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

  async updated(
    user: User,
    createUserTypeDto: CreateRequestPetitionDto,
    log: string,
    extraDetails: string,
  ) {
    let setDateByEvent = {};
    if (createUserTypeDto.log == 'Se rechazo el proyecto') {
      setDateByEvent = {
        rejectedDate: new Date(),
      };
    }
    if (createUserTypeDto.log == 'Se finalizo el proyecto') {
      setDateByEvent = {
        finishDate: new Date(),
      };
    }
    try {
      await this.requestPetitionRepository.save({
        ...createUserTypeDto,
        ...setDateByEvent,
      });

      const systemDocument = await this.requestPetitionRepository.findOne({
        relations: {
          proyectType: true,
          inspector: true,
        },
        where: { id: createUserTypeDto.id },
      });

      await this.requestPetitionLogsService.createLog({
        user,
        eventType: TypesEventLogs.update,
        result: TypesResultEventLogs.success,
        log,
        extraDetails,
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
    const user = await this.requestPetitionRepository.softDelete({
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

  async getPreinspections(user: User) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        inspector: true,
      },
      where: {
        status: StatusOrder.assigned,
        inspector: {
          id: user.id,
        },
      },
    });
    return {
      data,
    };
  }

  async getInternalInspections(user: User) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        inspector: true,
      },
      where: {
        status: StatusOrder.interrnalInspection,
        inspector: {
          id: user.id,
        },
      },
    });
    return {
      data,
    };
  }

  async getInstalations(user: User) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        instalator: true,
      },
      where: {
        status: StatusOrder.instalationAssigned,
        instalator: {
          id: user.id,
        },
      },
    });
    return {
      data,
    };
  }

  async getReasignedInstalations(user: User) {
    const data = await this.requestPetitionRepository.find({
      relations: {
        proyectType: true,
        instalator: true,
      },
      where: {
        status: StatusOrder.instalationReassigned,
        instalator: {
          id: user.id,
        },
      },
    });
    return {
      data,
    };
  }

  async getAdminDashboard(user: User) {
    const activeUsers = await this.userRepository.count();
    const completedProyects = await this.requestPetitionRepository.count({
      where: {
        status: In([StatusOrder.done, StatusOrder.store]),
      },
    });
    const activeProyects = await this.requestPetitionRepository.count({
      where: {
        status: In([
          StatusOrder.assigned,
          StatusOrder.inspectionAproved,
          StatusOrder.instalationAssigned,
          StatusOrder.instalationReassigned,
          StatusOrder.interrnalInspection,
          StatusOrder.observed,
        ]),
      },
    });
    const executingProyects = await this.requestPetitionRepository.count({
      where: {
        status: In([
          StatusOrder.instalationAssigned,
          StatusOrder.instalationReassigned,
        ]),
      },
    });
    return {
      activeUsers,
      completedProyects,
      activeProyects,
      executingProyects,
    };
  }

  async getVendorDashboard(user: User) {
    const completedProyects = await this.requestPetitionRepository.count({
      where: {
        vendor: {
          id: user.id,
        },
        status: In([StatusOrder.done, StatusOrder.store]),
      },
    });
    const activeProyects = await this.requestPetitionRepository.count({
      where: {
        vendor: {
          id: user.id,
        },
        status: In([
          StatusOrder.assigned,
          StatusOrder.inspectionAproved,
          StatusOrder.instalationAssigned,
          StatusOrder.instalationReassigned,
          StatusOrder.interrnalInspection,
          StatusOrder.observed,
        ]),
      },
    });
    const executingProyects = await this.requestPetitionRepository.count({
      where: {
        vendor: {
          id: user.id,
        },
        status: In([
          StatusOrder.instalationAssigned,
          StatusOrder.instalationReassigned,
        ]),
      },
    });
    return {
      completedProyects,
      activeProyects,
      executingProyects,
    };
  }
}
