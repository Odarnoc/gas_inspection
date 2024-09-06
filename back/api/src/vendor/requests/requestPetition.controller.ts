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
import { RequestPetitionService } from './requestPetition.service';
import { CreateRequestPetitionDto } from './dto/requestPetition.dto';

@Controller('requestPetition')
export class RequestPetitionController {
  constructor(private readonly userTypeService: RequestPetitionService) {}

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
  created(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateRequestPetitionDto,
  ) {
    return this.userTypeService.create(user, createUserTypeDto);
  }

  @Put('update')
  @Auth()
  update(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateRequestPetitionDto,
  ) {
    return this.userTypeService.updated(user, createUserTypeDto);
  }

  @Delete('delete/:userTypeId')
  @Auth()
  softDeleteUsers(@Param('userTypeId', ParseIntPipe) userTypeId: number) {
    return this.userTypeService.delete(userTypeId);
  }

  @Get('getPreinspections')
  @Auth()
  getPreinspections(@GetUser() user: User) {
    return this.userTypeService.getPreinspections(user);
  }

  @Get('getInternalInspections')
  @Auth()
  getInternalInspections(@GetUser() user: User) {
    return this.userTypeService.getInternalInspections(user);
  }
}
