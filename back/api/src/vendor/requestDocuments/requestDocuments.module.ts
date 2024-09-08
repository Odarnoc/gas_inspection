import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { RequestDocumentController } from './requestDocuments.controller';
import { RequestDocumentsService } from './requestDocuments.service';
import { RequestDocuments } from './entities/requestDocuments.entity';

@Module({
  controllers: [RequestDocumentController],
  providers: [RequestDocumentsService],
  imports: [
    TypeOrmModule.forFeature([RequestDocuments]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, RequestDocumentsService],
})
export class RequestDocumentsModule {}
