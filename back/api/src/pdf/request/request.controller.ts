import { Controller, Res, Post, Param, ParseIntPipe } from '@nestjs/common';
import { RequestPdfService } from './request.service';

@Controller('pdf/request')
export class RequestPdfController {
  constructor(private readonly userPdfService: RequestPdfService) {}

  @Post('getProyectPdf/:id')
  async getProyectPdf(@Res() res, @Param('id', ParseIntPipe) id: number) {
    const buffer = await this.userPdfService.getProyectPdf(id);

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=proyecto-${id}.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }
}
