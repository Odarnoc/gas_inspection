import { IsString, IsNumber } from 'class-validator';

export class PasswordUserDto {
  @IsNumber()
  userId: number;

  @IsString()
  password: string;
}
