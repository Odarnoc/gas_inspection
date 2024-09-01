import { Type } from 'class-transformer';
import {
  IsDateString,
  IsNumber,
  IsObject,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import { ProyectType } from 'src/admin/user-type/entities/proyectType.entity';
import { Location } from 'src/common/interfaces/location.interface';

export class CreateRequestPetitionDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsString()
  @IsOptional()
  firstName?: string;

  @IsString()
  @IsOptional()
  paternalName?: string;

  @IsString()
  @IsOptional()
  maternalName?: string;

  @IsString()
  @IsOptional()
  phone?: string;

  @IsString()
  @IsOptional()
  cellphone?: string;

  @IsString()
  @IsOptional()
  zone?: string;

  @IsString()
  @IsOptional()
  avenue?: string;

  @IsString()
  @IsOptional()
  street?: string;

  @IsString()
  @IsOptional()
  door?: string;

  @IsString()
  @IsOptional()
  references?: string;

  @IsObject()
  @ValidateNested()
  @Type(() => Location)
  location?: Location;

  @IsString()
  @IsOptional()
  identityCard?: string;

  @IsString()
  @IsOptional()
  waterBill?: string;

  @IsString()
  @IsOptional()
  electricityBill?: string;

  @IsString()
  @IsOptional()
  realFolio?: string;

  @IsDateString()
  @IsOptional()
  startDate?: Date;

  @IsDateString()
  @IsOptional()
  limitDate?: Date;

  @IsObject()
  @IsOptional()
  @Type(() => ProyectType)
  proyectType?: ProyectType;
}
