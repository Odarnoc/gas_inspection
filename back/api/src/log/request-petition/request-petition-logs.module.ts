import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RequestPetitionLogs } from './entities/request-petition-logs.entity';
import { AuthModule } from 'src/auth/auth.module';
import { RequestPetitionLogsService } from './request-petition-logs.service';
import { forwardRef } from '@nestjs/common/utils';
import { RequestPetitionLogsController } from './request-petition-logs.controller';

@Module({
  controllers: [RequestPetitionLogsController],
  providers: [RequestPetitionLogsService],
  imports: [
    TypeOrmModule.forFeature([RequestPetitionLogs]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, RequestPetitionLogsService],
})
export class RequestPetitionLogsModule {}
