import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { CovergeLinesController } from './covergeLines.controller';
import { CovergeLinesService } from './covergeLines.service';
import { CovergeLines } from './entities/covergeLines.entity';

@Module({
  controllers: [CovergeLinesController],
  providers: [CovergeLinesService],
  imports: [
    TypeOrmModule.forFeature([CovergeLines]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, CovergeLinesService],
})
export class CovergeLinesModule {}
