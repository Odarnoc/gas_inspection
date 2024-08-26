import { IsString, MinLength } from 'class-validator';
import { ErrorCode } from 'src/common/glob/error';

export class PasswordUserDto {
  @IsString()
  @MinLength(6, { message: `${ErrorCode.MINLENGTHPASSWORD}` })
  password: string;
}
