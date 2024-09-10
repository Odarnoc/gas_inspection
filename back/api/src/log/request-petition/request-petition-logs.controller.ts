import { Body, Controller, Post } from '@nestjs/common';
import { PaginationCompleteDto } from 'src/common/dto/pagination.dto';
import { RequestPetitionLogsService } from './request-petition-logs.service';

@Controller('logs/requestPetition')
export class RequestPetitionLogsController {
  constructor(
    private readonly requestPetitionLogsService: RequestPetitionLogsService,
  ) {}

  @Post('getTable')
  getTable(@Body() paginationDto: PaginationCompleteDto) {
    return this.requestPetitionLogsService.getTable(paginationDto);
  }
}
