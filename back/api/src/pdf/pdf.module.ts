import { Module } from '@nestjs/common';
import { UserPdfController } from './materials/materials.controller';
import { UserPdfService } from './materials/materials.service';
import { AuthModule } from 'src/auth/auth.module';
import { RequestPetitionModule } from 'src/vendor/requests/requestPetition.module';
import { RequestMaterialsModule } from 'src/vendor/requestMaterials/requestMaterials.module';
import { RequestPdfController } from './request/request.controller';
import { RequestPdfService } from './request/request.service';
import { RequestDocumentsModule } from 'src/vendor/requestDocuments/requestDocuments.module';

@Module({
  controllers: [UserPdfController, RequestPdfController],
  providers: [UserPdfService, RequestPdfService],
  imports: [
    AuthModule,
    RequestMaterialsModule,
    RequestPetitionModule,
    RequestDocumentsModule,
  ],
  exports: [UserPdfService],
})
export class PdfModule {}
