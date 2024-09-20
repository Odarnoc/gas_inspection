import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { join } from 'path';
import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import { RequestPetitionService } from 'src/vendor/requests/requestPetition.service';
import { RequestMaterialsService } from '../../vendor/requestMaterials/RequestMaterials.service';

// eslint-disable-next-line @typescript-eslint/no-var-requires
const PDFDocument = require('pdfkit-table');

@Injectable()
export class UserPdfService {
  constructor(
    @Inject(RequestPetitionService)
    private readonly requestPetitionService: RequestPetitionService,

    @Inject(RequestMaterialsService)
    private readonly requestMaterialsService: RequestMaterialsService,

    private readonly i18n: I18nService,
  ) {}

  private imageLogo = join(__dirname, '..', '..', 'assets/Logo.png');

  async getAllByRequest(requestId: number): Promise<Buffer> {
    const pdfBuffer: Buffer = await new Promise(async (resolve) => {
      const doc = new PDFDocument({
        size: 'LETTER',
        bufferPages: true,
      });

      const { data } = await this.requestPetitionService.get(requestId);

      if (!data) {
        throw new BadRequestException(
          this.i18n.t('warnings.no_data', {
            lang: I18nContext.current().lang,
          }),
        );
      }
      // aqui comieza edicion de pdf

      await this.generateHeader(doc);
      doc.moveDown();

      await this.userBody(doc, data);
      doc.moveDown();

      await this.generateFooter(doc);

      // aqui finaliza edicion de pdf

      const buffer = [];
      doc.on('data', buffer.push.bind(buffer));
      doc.on('end', () => {
        const data = Buffer.concat(buffer);
        resolve(data);
      });
      doc.end();
    });

    return pdfBuffer;
  }

  async generateHeader(doc: any) {
    doc
      .image(this.imageLogo, 50, 45, { width: 50 })
      .fillColor('#444444')
      .fontSize(20)
      .text('L.I.V GAS', 110, 57)
      .moveDown();
  }

  async generateFooter(doc: any) {
    const pages = doc.bufferedPageRange();
    for (let i = 0; i < pages.count; i++) {
      doc.switchToPage(i);
      const oldBottomMargin = doc.page.margins.bottom;
      doc.page.margins.bottom = 0;
      doc.text(
        `Página: ${i + 1} de ${pages.count}`,
        0,
        doc.page.height - oldBottomMargin / 2,
        { align: 'center' },
      );
      doc.page.margins.bottom = oldBottomMargin;
    }
  }

  async userBody(doc: any, request: RequestPetition) {
    const { data } = await this.requestMaterialsService.getMaterialsByRequest(
      request.id,
    );
    const table = {
      headers: [
        { label: 'Material', property: 'material' },
        {
          label: 'Cantidad',
          property: 'quantity',
        },
      ],
      datas: data,
    };

    await doc.table(table, {
      prepareHeader: () => doc.fontSize(8),
      prepareRow: (row, indexColumn, indexRow, rectRow, rectCell) => {
        doc.fontSize(8);
        indexColumn === 0 && doc.addBackground(rectRow, 'white', 0.15);
      },
    });
  }
}
