import { IsNumber, IsOptional, IsString } from 'class-validator';

export class CreateProyectTypeDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsString()
  name: string;

  @IsString()
  details: string;
}
