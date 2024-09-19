import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { RequestMaterialsController } from './requestMaterials.controller';
import { RequestMaterialsService } from './RequestMaterials.service';
import { RequestMaterials } from './entities/requestMaterials.entity';

@Module({
  controllers: [RequestMaterialsController],
  providers: [RequestMaterialsService],
  imports: [
    TypeOrmModule.forFeature([RequestMaterials]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, RequestMaterialsService],
})
export class RequestMaterialsModule {}
