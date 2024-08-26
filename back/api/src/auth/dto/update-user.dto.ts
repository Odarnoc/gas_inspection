import { PartialType } from '@nestjs/mapped-types';
import { Type } from 'class-transformer';
import {
  IsBoolean,
  IsDateString,
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';
import { CreateUserDto } from './create-user.dto';

export class UpdateUserDto extends PartialType(CreateUserDto) {
  @IsNumber()
  @IsOptional()
  @Type(() => Number)
  id?: number;

  @IsString()
  @IsOptional()
  @MaxLength(1200)
  image?: string;

  @IsString()
  @IsOptional()
  @MaxLength(1200)
  imageToChange?: string;

  @IsBoolean()
  @IsOptional()
  isImageRequested?: boolean;

  @IsBoolean()
  @IsOptional()
  isToUpdate?: boolean;

  @IsBoolean()
  @IsOptional()
  isImageVerified?: boolean;

  @IsDateString()
  @IsOptional()
  lastImageProfileUpdate?: Date;

  @IsBoolean()
  @IsOptional()
  isImageUpdate?: boolean;

  @IsBoolean()
  @IsOptional()
  isVerify?: boolean;
}
