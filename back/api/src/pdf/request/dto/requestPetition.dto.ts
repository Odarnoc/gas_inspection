import { IsBoolean, IsOptional } from 'class-validator';

export class CreatePDFRequestPetitionDto {
  @IsBoolean()
  @IsOptional()
  isometricSelected?: boolean;

  @IsBoolean()
  @IsOptional()
  floorPlanSelected?: boolean;

  @IsBoolean()
  @IsOptional()
  materialsSelected?: boolean;

  @IsOptional()
  selectedExtraDocumentIDS?: number[];
}
