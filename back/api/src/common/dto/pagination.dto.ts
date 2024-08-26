import { Type } from 'class-transformer';
import {
  IsNumber,
  IsOptional,
  IsPositive,
  Max,
  IsBoolean,
  IsString,
} from 'class-validator';

export class PaginationDto {
  @IsOptional()
  @IsPositive()
  @Type(() => Number)
  @Max(100)
  limit?: number;

  @IsOptional()
  @IsNumber()
  @Type(() => Number)
  offset?: number;
}

export class PaginationCompleteDto {
  @IsOptional()
  @IsBoolean()
  descending?: boolean;

  @IsOptional()
  @IsNumber()
  page?: number;

  @IsOptional()
  @IsNumber()
  rowsPerPage?: number;

  @IsOptional()
  @IsString()
  sortBy?: string;

  @IsOptional()
  @IsNumber()
  offset?: number;

  @IsOptional()
  where?: any;

  @IsOptional()
  filters?: any;

  @IsOptional()
  select?: any;

  @IsOptional()
  @IsBoolean()
  isCSV?: boolean;

  @IsOptional()
  @IsBoolean()
  withDeleted?: boolean;
}
