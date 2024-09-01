import { Transform } from 'class-transformer';
import {
  IsDateString,
  IsEmail,
  IsOptional,
  IsString,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
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
  @IsEmail()
  @IsOptional()
  @Transform(({ value }) => value?.toLowerCase().trim())
  email?: string;

  @IsString()
  @IsOptional()
  phone?: string;

  @IsString()
  @IsOptional()
  cellphone?: string;

  @IsString()
  @IsOptional()
  password?: string;

  @IsString()
  @IsOptional()
  image?: string;

  @IsString()
  @IsOptional()
  rol?: string;

  @IsString()
  @IsOptional()
  address?: string;

  @IsString()
  @IsOptional()
  professionalTitle?: string;

  @IsString()
  @IsOptional()
  professionalTitleFile?: string;

  @IsString()
  @IsOptional()
  cv?: string;

  @IsDateString()
  @IsOptional()
  incomeDate?: Date;

  @IsDateString()
  @IsOptional()
  conclusionDate?: Date;
}
