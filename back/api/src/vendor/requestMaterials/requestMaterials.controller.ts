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
import { RequestMaterialsService } from './RequestMaterials.service';
import { CreateRequestMaterialsDto } from './dto/create-requestMaterials.dto';

@Controller('requestMaterials')
export class RequestMaterialsController {
  constructor(private readonly proyectTypeService: RequestMaterialsService) {}

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
    @Body() createUserTypeDto: CreateRequestMaterialsDto,
  ) {
    return this.proyectTypeService.create(user, createUserTypeDto);
  }

  @Put('update')
  @Auth()
  update(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateRequestMaterialsDto,
  ) {
    return this.proyectTypeService.updated(user, createUserTypeDto);
  }

  @Delete('delete/:id')
  @Auth()
  softDeleteUsers(@Param('id', ParseIntPipe) id: number) {
    return this.proyectTypeService.delete(id);
  }

  @Get('getDocuments/:id')
  @Auth()
  getInternalInspections(@Param('id', ParseIntPipe) id: number) {
    return this.proyectTypeService.getDocuments(id);
  }
}
