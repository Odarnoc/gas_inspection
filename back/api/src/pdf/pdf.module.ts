import { Module } from '@nestjs/common';
import { UserPdfController } from './materials/materials.controller';
import { UserPdfService } from './materials/materials.service';
import { AuthModule } from 'src/auth/auth.module';
import { RequestPetitionModule } from 'src/vendor/requests/requestPetition.module';
import { RequestMaterialsModule } from 'src/vendor/requestMaterials/requestMaterials.module';

@Module({
  controllers: [UserPdfController],
  providers: [UserPdfService],
  imports: [AuthModule, RequestMaterialsModule, RequestPetitionModule],
  exports: [UserPdfService],
})
export class PdfModule {}
