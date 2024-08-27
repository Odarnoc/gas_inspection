import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from 'src/auth/auth.module';
import { ProyectTypeController } from './proyectType.controller';
import { ProyectTypeService } from './proyectType.service';
import { UserType } from './entities/proyectType.entity';

@Module({
  controllers: [ProyectTypeController],
  providers: [ProyectTypeService],
  imports: [TypeOrmModule.forFeature([UserType]), forwardRef(() => AuthModule)],
  exports: [TypeOrmModule, ProyectTypeService],
})
export class ProyectTypeModule {}
