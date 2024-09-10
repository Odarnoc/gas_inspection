import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import handleDbExceptions from 'src/common/exceptions/error.db.exception';
import { Repository } from 'typeorm';
import { RequestPetitionLogs } from './entities/request-petition-logs.entity';
import { PaginationCompleteDto } from '../../common/dto/pagination.dto';
import { PAGINATION_DEFAULT_VALUES } from '../../common/constants/pagination';
import { GetManualOrderLogDto } from './dto/request-petition-log.dto';
import { getOrderBy, getOrderType } from '../../common/helpers/pagination';
import { User } from 'src/auth/entities/user.entity';
import { CreateRequestPetitionLogDto } from './dto/create-request-petition-log.dto';

@Injectable()
export class RequestPetitionLogsService {
  private readonly logger = new Logger(RequestPetitionLogsService.name);

  constructor(
    @InjectRepository(RequestPetitionLogs)
    private readonly requestPetitionLogsRepository: Repository<RequestPetitionLogs>,
  ) {}

  async createLog(createManualOrderLogDto: CreateRequestPetitionLogDto) {
    try {
      const log = this.requestPetitionLogsRepository.create({
        ...createManualOrderLogDto,
      });
      this.requestPetitionLogsRepository.save(log);
      return log;
    } catch (error) {
      handleDbExceptions(error, this.logger);
    }
  }

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
      await this.requestPetitionLogsRepository.findAndCount({
        relations: {
          user: true,
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
}
