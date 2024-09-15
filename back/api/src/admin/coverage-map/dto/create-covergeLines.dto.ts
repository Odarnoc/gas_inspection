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
}
