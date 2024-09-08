import { Type } from 'class-transformer';
import { IsNumber, IsObject, IsOptional, IsString } from 'class-validator';
import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';

export class CreateRequestDocumentDto {
  @IsNumber()
  @IsOptional()
  id?: number;

  @IsOptional()
  @IsString()
  documentUrl: string;

  @IsObject()
  @IsOptional()
  @Type(() => RequestPetition)
  requestPetition: RequestPetition;
}
