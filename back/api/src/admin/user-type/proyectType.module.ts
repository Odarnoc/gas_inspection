import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { ProyectTypeController } from './proyectType.controller';
import { ProyectTypeService } from './proyectType.service';
import { ProyectType } from './entities/proyectType.entity';

@Module({
  controllers: [ProyectTypeController],
  providers: [ProyectTypeService],
  imports: [
    TypeOrmModule.forFeature([ProyectType]),
    forwardRef(() => AuthModule),
  ],
  exports: [TypeOrmModule, ProyectTypeService],
})
export class ProyectTypeModule {}
