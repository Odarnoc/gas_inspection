import {
  Body,
  Controller,
  Post,
  Put,
  ParseIntPipe,
  Param,
  Delete,
  Get,
} from '@nestjs/common';
import { Auth, GetUser } from 'src/auth/decorators';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { User } from '../../auth/entities/user.entity';
import { ProyectTypeService } from './proyectType.service';
import { CreateProyectTypeDto } from './dto/create-proyectType.dto';

@Controller('proyectTypes')
export class ProyectTypeController {
  constructor(private readonly proyectTypeService: ProyectTypeService) {}

  @Post('getTable')
  getTable(@Body() paginationDto: PaginationCompleteDto) {
    return this.proyectTypeService.getTable(paginationDto);
  }

  @Post('get/:id')
  @Auth()
  get(@Param('id', ParseIntPipe) id: number) {
    return this.proyectTypeService.get(id);
  }

  @Post('create')
  @Auth()
  created(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateProyectTypeDto,
  ) {
    return this.proyectTypeService.create(user, createUserTypeDto);
  }

  @Put('update')
  @Auth()
  update(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateProyectTypeDto,
  ) {
    return this.proyectTypeService.updated(user, createUserTypeDto);
  }

  @Delete('delete/:userTypeId')
  @Auth()
  softDeleteUsers(@Param('userTypeId', ParseIntPipe) userTypeId: number) {
    return this.proyectTypeService.delete(userTypeId);
  }

  @Get('options')
  getCitiesOptions() {
    return this.proyectTypeService.getProyectTypeOptions();
  }
}
