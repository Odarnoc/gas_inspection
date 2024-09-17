import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { ProyectTypeController } from './proyectType.controller';
import { ProyectTypeService } from './proyectType.service';
import { Materials } from './entities/proyectType.entity';

@Module({
  controllers: [ProyectTypeController],
  providers: [ProyectTypeService],
  imports: [
    TypeOrmModule.forFeature([Materials]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, ProyectTypeService],
})
export class ProyectTypeModule {}
