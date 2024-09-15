import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import handleDbExceptions from '../../common/exceptions/error.db.exception';
import { User } from '../../auth/entities/user.entity';
import { DEFAULT_RESULT } from '../../common/constants/response';
import { CovergeLines } from './entities/covergeLines.entity';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { CreateCovergeLinesDto } from './dto/create-covergeLines.dto';
import { LineString } from 'geojson';
import { linesCordinatesToLatLngParser } from 'src/common/helpers/parsers/coordinatesParsers';

@Injectable()
export class CovergeLinesService {
  private readonly logger = new Logger(CovergeLinesService.name);

  constructor(
    @InjectRepository(CovergeLines)
    private readonly covergeLinesRepository: Repository<CovergeLines>,

    private readonly i18n: I18nService,
  ) {}

  async getAll() {
    const data = await this.covergeLinesRepository.find();
    return {
      data: linesCordinatesToLatLngParser(data),
    };
  }

  async create(user: User, createUserTypeDto: CreateCovergeLinesDto) {
    try {
      const lineCreated: LineString = {
        type: 'LineString',
        coordinates: createUserTypeDto.line,
      };

      const systemDocument = await this.covergeLinesRepository.save({
        ...createUserTypeDto,
        line: lineCreated,
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

  async updated(user: User, createUserTypeDto: CreateCovergeLinesDto) {
    try {
      const lineCreated: LineString = {
        type: 'LineString',
        coordinates: createUserTypeDto.line,
      };
      const systemDocument = await this.covergeLinesRepository.save({
        ...createUserTypeDto,
        line: lineCreated,
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
    const user = await this.covergeLinesRepository.softDelete({
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
}
