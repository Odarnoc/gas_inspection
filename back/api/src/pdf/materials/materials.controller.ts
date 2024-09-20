import { Controller, Res, Post, Param, ParseIntPipe } from '@nestjs/common';
import { UserPdfService } from './materials.service';

@Controller('pdf/materials')
export class UserPdfController {
  constructor(private readonly userPdfService: UserPdfService) {}

  @Post('getAllByRequest/:id')
  async getUserDocumetsPdf(@Res() res, @Param('id', ParseIntPipe) id: number) {
    const buffer = await this.userPdfService.getAllByRequest(id);

    res.set({
      'Content-Type': 'application/pdf',
      'Content-Disposition': `attachment; filename=materiales.pdf`,
      'Content-Length': buffer.length,
    });

    res.end(buffer);
  }
}
