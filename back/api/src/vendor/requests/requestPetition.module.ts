import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { RequestPetitionController } from './requestPetition.controller';
import { RequestPetitionService } from './requestPetition.service';
import { RequestPetition } from './entities/requestPetition.entity';
import { RequestPetitionLogsModule } from 'src/log/request-petition/request-petition-logs.module';

@Module({
  controllers: [RequestPetitionController],
  providers: [RequestPetitionService],
  imports: [
    TypeOrmModule.forFeature([RequestPetition]),
    forwardRef(() => AuthModule),
    forwardRef(() => RequestPetitionLogsModule),
  ],
  exports: [TypeOrmModule, RequestPetitionService],
})
export class RequestPetitionModule {}
