import { IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateCovergeLinesDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsOptional()
  line?: number[][];

  @IsString()
  @IsOptional()
  color?: string;

  @IsString()
  @IsOptional()
  city: string;

  @IsString()
  @IsOptional()
  zone: string;

  @IsString()
  @IsOptional()
  avenue: string;

  @IsString()
  @IsOptional()
  streets: string;
}
