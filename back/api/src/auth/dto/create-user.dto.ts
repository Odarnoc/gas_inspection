import { Transform } from 'class-transformer';
import {
  IsEmail,
  IsOptional,
  IsString,
  IsUUID,
  MinLength,
} from 'class-validator';

const defaultCountryId = 1;

export class CreateUserDto {
  @IsString()
  @MinLength(4)
  @IsOptional()
  fullName?: string;

  @IsString()
  @IsEmail()
  @IsOptional()
  @Transform(({ value }) => value?.toLowerCase().trim())
  email?: string;

  @IsString()
  @IsOptional()
  rfc?: string;

  @IsString()
  @IsOptional()
  phoneCountryISOCode?: string;

  @IsString()
  @IsOptional()
  phonePrefix?: string;

  @IsString()
  @MinLength(6)
  @IsOptional()
  phone?: string;

  @IsString()
  @MinLength(6)
  @IsOptional()
  password?: string;

  @IsString()
  @IsOptional()
  image?: string;

  @IsUUID()
  @IsOptional()
  idDevice?: string;

  @IsOptional()
  tokenPush?: string;

  @IsOptional()
  user?: number;

  @IsOptional()
  internal_register?: boolean;

  @IsOptional()
  rol?: number;

  @IsString()
  @IsOptional()
  code?: string;

  @IsOptional()
  groupsId?: number;

  @IsOptional()
  cityId?: number;

  @IsOptional()
  countryId?: number = defaultCountryId;

  @IsOptional()
  userTypeId?: number;
}
