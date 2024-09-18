import { Transform } from 'class-transformer';
import { IsEmail, IsString } from 'class-validator';

export class LoginUserDto {
  @IsString()
  @IsEmail()
  @Transform(({ value }) => value?.toLowerCase().trim())
  email: string;

  @IsString()
  password: string;
}
