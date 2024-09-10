import { Type } from 'class-transformer';
import { PaginationCompleteDto } from '../../../common/dto/pagination.dto';
import { PartialType } from '@nestjs/mapped-types';
import { IsNumber } from 'class-validator';

export class GetManualOrderLogDto extends PartialType(PaginationCompleteDto) {
  @IsNumber()
  @Type(() => Number)
  driverId: number;
}
