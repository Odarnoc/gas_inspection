import { Type } from 'class-transformer';
import { IsObject, IsString, ValidateNested } from 'class-validator';
import { User } from 'src/auth/entities/user.entity';

export class CreateRequestPetitionLogDto {
  @IsString()
  eventType: string;

  @IsString()
  log: string;

  @IsString()
  result: string;

  @IsString()
  extraDetails: string;

  @IsObject()
  @ValidateNested()
  @Type(() => User)
  user: User;
}
