import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { RequestPetitionController } from './requestPetition.controller';
import { RequestPetitionService } from './requestPetition.service';
import { RequestPetition } from './entities/requestPetition.entity';

@Module({
  controllers: [RequestPetitionController],
  providers: [RequestPetitionService],
  imports: [
    TypeOrmModule.forFeature([RequestPetition]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, RequestPetitionService],
})
export class RequestPetitionModule {}
