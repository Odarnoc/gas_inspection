import { IsDateString, IsOptional } from 'class-validator';

export class ReportPDFDto {
  @IsDateString()
  @IsOptional()
  startDate?: Date;

  @IsDateString()
  @IsOptional()
  endDate?: Date;
}
