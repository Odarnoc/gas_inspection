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
import { User } from '../../auth/entities/user.entity';
import { CovergeLinesService } from './covergeLines.service';
import { CreateCovergeLinesDto } from './dto/create-covergeLines.dto';

@Controller('covergeLines')
export class CovergeLinesController {
  constructor(private readonly covergeLinesService: CovergeLinesService) {}

  @Get('getAll')
  @Auth()
  getAll() {
    return this.covergeLinesService.getAll();
  }

  @Post('create')
  @Auth()
  created(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateCovergeLinesDto,
  ) {
    return this.covergeLinesService.create(user, createUserTypeDto);
  }

  @Put('update')
  @Auth()
  update(
    @GetUser() user: User,
    @Body() createUserTypeDto: CreateCovergeLinesDto,
  ) {
    return this.covergeLinesService.updated(user, createUserTypeDto);
  }

  @Delete('delete/:userTypeId')
  @Auth()
  softDeleteUsers(@Param('userTypeId', ParseIntPipe) userTypeId: number) {
    return this.covergeLinesService.delete(userTypeId);
  }
}
