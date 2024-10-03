import {
  Controller,
  Res,
  Post,
  Param,
  ParseIntPipe,
  Body,
} from '@nestjs/common';
import { RequestPdfService } from './request.service';
import { CreatePDFRequestPetitionDto } from './dto/requestPetition.dto';

@Controller('pdf/request')
export class RequestPdfController {
  constructor(private readonly userPdfService: RequestPdfService) {}

  @Post('getProyectPdf/:id')
  async getProyectPdf(
    @Res() res,
    @Param('id', ParseIntPipe) id: number,
    @Body() createPDFRequestPetitionDto: CreatePDFRequestPetitionDto,
  ) {
    const buffer = await this.userPdfService.getProyectPdf(
      id,
      createPDFRequestPetitionDto,
    );

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${id}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  @Post('getInProgressReport')
  async getInProgressReport(@Res() res) {
    const buffer = await this.userPdfService.getInProgressReport();

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${1}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  @Post('getEfectivityReport')
  async getEfectivityReport(@Res() res) {
    const buffer = await this.userPdfService.getInProgressReport();

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${1}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  @Post('getRejectedReport')
  async getRejectedReport(@Res() res) {
    const buffer = await this.userPdfService.getInProgressReport();

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${1}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }

  @Post('getActorReport')
  async getActorReport(@Res() res) {
    const buffer = await this.userPdfService.getInProgressReport();

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${1}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }
}
