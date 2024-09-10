import { Type } from 'class-transformer';
import {
  IsBoolean,
  IsDateString,
  IsNumber,
  IsObject,
  IsOptional,
  IsString,
  ValidateNested,
} from 'class-validator';
import { ProyectType } from 'src/admin/user-type/entities/proyectType.entity';
import { User } from 'src/auth/entities/user.entity';
import { Location } from 'src/common/interfaces/location.interface';

export class CreateRequestPetitionDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsNumber()
  @IsOptional()
  status?: number;

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

  @IsOptional()
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

  @IsString()
  @IsOptional()
  isometric?: string;

  @IsString()
  @IsOptional()
  floorPlan?: string;

  @IsString()
  @IsOptional()
  observations?: string;

  @IsBoolean()
  @IsOptional()
  minimumVolume?: boolean;

  @IsBoolean()
  @IsOptional()
  airSupply?: boolean;

  @IsBoolean()
  @IsOptional()
  airOutlet?: boolean;

  @IsBoolean()
  @IsOptional()
  rapidAeration?: boolean;

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

  @IsObject()
  @IsOptional()
  @Type(() => User)
  inspector?: User;

  @IsString()
  @IsOptional()
  log?: string;
}
