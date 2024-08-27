import {
  IsNumber,
  IsOptional,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserTypeDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsString()
  @MinLength(1)
  @MaxLength(1200)
  name: string;
}
