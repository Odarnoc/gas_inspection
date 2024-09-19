import { Type } from 'class-transformer';
import { IsNumber, IsObject, IsOptional, IsString } from 'class-validator';
import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';

export class CreateRequestMaterialsDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsOptional()
  @IsString()
  material: string;

  @IsNumber()
  @IsOptional()
  quantity?: number;

  @IsObject()
  @IsOptional()
  @Type(() => RequestPetition)
  requestPetition: RequestPetition;
}
