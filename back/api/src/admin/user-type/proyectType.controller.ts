import {
  Body,
  Controller,
  Post,
  Put,
  ParseIntPipe,
  Param,
} from '@nestjs/common';
import { Auth, GetUser } from 'src/auth/decorators';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { User } from '../../auth/entities/user.entity';
import { ProyectTypeService } from './proyectType.service';
import { CreateUserTypeDto } from './dto/create-proyectType.dto';

@Controller('proyectTypes')
export class ProyectTypeController {
  constructor(private readonly userTypeService: ProyectTypeService) {}

  @Post('getTable')
  getTable(@Body() paginationDto: PaginationCompleteDto) {
    return this.userTypeService.getTable(paginationDto);
  }

  @Post('get/:id')
  @Auth()
  get(@Param('id', ParseIntPipe) id: number) {
    return this.userTypeService.get(id);
  }

  @Post('create')
  @Auth()
  created(@GetUser() user: User, @Body() createUserTypeDto: CreateUserTypeDto) {
    return this.userTypeService.create(user, createUserTypeDto);
  }

  @Put('update')
  @Auth()
  update(@GetUser() user: User, @Body() createUserTypeDto: CreateUserTypeDto) {
    return this.userTypeService.updated(user, createUserTypeDto);
  }
}
