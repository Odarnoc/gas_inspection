import { BadRequestException, Inject, Injectable } from '@nestjs/common';
import { I18nContext, I18nService } from 'nestjs-i18n';
import { join } from 'path';
import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import { RequestPetitionService } from 'src/vendor/requests/requestPetition.service';
import { RequestMaterialsService } from '../../vendor/requestMaterials/RequestMaterials.service';
import { fetchBufferImage } from 'src/common/helpers/fileHelpers';
import { RequestDocumentsService } from 'src/vendor/requestDocuments/requestDocuments.service';
import {
  clientPDFParser,
  techPDFParser,
} from 'src/common/helpers/parsers/clientInfoParser';
import { CreatePDFRequestPetitionDto } from './dto/requestPetition.dto';
import { ReportPDFDto } from './dto/reports.dto';
import { exportRejectedPetitionParserMap } from 'src/common/helpers/parsers/petitionParser';

// eslint-disable-next-line @typescript-eslint/no-var-requires
const PDFDocument = require('pdfkit-table');

@Injectable()
export class RequestPdfService {
  constructor(
    @Inject(RequestPetitionService)
    private readonly requestPetitionService: RequestPetitionService,

    @Inject(RequestDocumentsService)
    private readonly requestDocumentsService: RequestDocumentsService,

    private readonly i18n: I18nService,
  ) {}

  private imageLogo = join(__dirname, '..', '..', 'assets/Logo.png');

  async getProyectPdf(
    requestId: number,
    createPDFRequestPetitionDto: CreatePDFRequestPetitionDto,
  ): Promise<Buffer> {
    const pdfBuffer: Buffer = await new Promise(async (resolve) => {
      const doc = new PDFDocument({
        size: 'LETTER',
        margin: 30,
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
      doc.moveDown();
      doc.moveDown();

      await this.clientInformation(doc, data);
      doc.moveDown();
      doc.moveDown();
      doc.moveDown();

      await this.techInformation(doc, data);
      doc.moveDown();

      await this.addSpecificFiles(doc, data, createPDFRequestPetitionDto);

      await this.addExtraFiles(doc, data, createPDFRequestPetitionDto);

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

  async getInProgressReport(reportPDFDto: ReportPDFDto): Promise<Buffer> {
    const pdfBuffer: Buffer = await new Promise(async (resolve) => {
      const doc = new PDFDocument({
        size: 'LETTER',
        margin: 30,
        bufferPages: true,
      });
      // aqui comieza edicion de pdf

      await this.generateHeader(doc);
      doc.moveDown();
      doc.moveDown();
      doc.moveDown();

      await this.reportInProgresTable(doc, reportPDFDto);
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

  async getRejectedReport(reportPDFDto: ReportPDFDto): Promise<Buffer> {
    const pdfBuffer: Buffer = await new Promise(async (resolve) => {
      const doc = new PDFDocument({
        size: 'LETTER',
        margin: 30,
        bufferPages: true,
      });
      // aqui comieza edicion de pdf

      await this.generateHeader(doc);
      doc.moveDown();
      doc.moveDown();
      doc.moveDown();

      await this.reportRejectedTable(doc, reportPDFDto);
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

  async addSpecificFiles(
    doc: any,
    request: RequestPetition,
    createPDFRequestPetitionDto: CreatePDFRequestPetitionDto,
  ) {
    if (createPDFRequestPetitionDto.isometricSelected) {
      const isometric = await fetchBufferImage(request.isometric);
      doc.addPage().image(isometric, {
        fit: [doc.page.width - 60, doc.page.height - 60],
        align: 'center',
        valign: 'center',
      });
    }

    if (createPDFRequestPetitionDto.floorPlanSelected) {
      const floorPlan = await fetchBufferImage(request.floorPlan);
      doc.addPage().image(floorPlan, {
        fit: [doc.page.width - 60, doc.page.height - 60],
        align: 'center',
        valign: 'center',
      });
    }

    if (createPDFRequestPetitionDto.materialsSelected) {
      const materials = await fetchBufferImage(request.materials);
      doc.addPage().image(materials, {
        fit: [doc.page.width - 60, doc.page.height - 60],
        align: 'center',
        valign: 'center',
      });
    }
  }

  async addExtraFiles(
    doc: any,
    request: RequestPetition,
    createPDFRequestPetitionDto: CreatePDFRequestPetitionDto,
  ) {
    const extras = await this.requestDocumentsService.getDocumentsForPDF(
      createPDFRequestPetitionDto.selectedExtraDocumentIDS,
    );

    for await (const document of extras.data) {
      if (document.documentUrl) {
        const url = await fetchBufferImage(document.documentUrl);
        doc.addPage().image(url, {
          fit: [doc.page.width - 60, doc.page.height - 60],
          align: 'center',
          valign: 'center',
        });
      }
    }
  }

  async generateHeader(doc: any) {
    doc
      .image(this.imageLogo, 50, 45, { width: 50 })
      .fillColor('#444444')
      .fontSize(20)
      .text('L.I.V GAS', 110, 57)
      .text('', 30, 57)
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

  async clientInformation(doc: any, request: RequestPetition) {
    const clientInfo = clientPDFParser(request);
    const table = {
      title: 'Información del cliente',
      headers: [
        { label: 'Cliente', property: 'fullName' },
        {
          label: 'CI',
          property: 'ci',
        },
        { label: 'Tipo de proyecto', property: 'proyectType' },
        { label: 'Teléfono / Celular', property: 'phones' },
        { label: 'Direccion', property: 'address' },
      ],
      datas: [clientInfo],
    };

    await doc.table(table, {
      prepareHeader: () => doc.fontSize(8),
      prepareRow: (row, indexColumn, indexRow, rectRow, rectCell) => {
        doc.fontSize(8);
        indexColumn === 0 && doc.addBackground(rectRow, 'white', 0.15);
      },
    });
  }

  async techInformation(doc: any, request: RequestPetition) {
    const techInfo = techPDFParser(request);
    const table = {
      title: 'Información técnica',
      headers: [
        { label: 'Volumen mínimo', property: 'minimumVolume' },
        {
          label: 'Alimentación de aire',
          property: 'airSupply',
        },
        { label: 'Salida de aire', property: 'airOutlet' },
        { label: 'Aireación rápida', property: 'rapidAeration' },
        { label: 'Verificación de presión', property: 'pressureCheck' },
        { label: 'Verificación de válvulas', property: 'valvuleCheck' },
        { label: 'Verificación de fugas', property: 'leakCheck' },
        { label: 'Ventilación', property: 'ventilation' },
        { label: 'Limpieza de área', property: 'areaCleaning' },
      ],
      datas: [techInfo],
    };

    await doc.table(table, {
      prepareHeader: () => doc.fontSize(8),
      prepareRow: (row, indexColumn, indexRow, rectRow, rectCell) => {
        doc.fontSize(8);
        indexColumn === 0 && doc.addBackground(rectRow, 'white', 0.15);
      },
    });
  }

  async reportInProgresTable(doc: any, reportPDFDto: ReportPDFDto) {
    const { data } = await this.requestPetitionService.getInProgress(
      reportPDFDto,
    );
    const datas = exportRejectedPetitionParserMap(data);
    const table = {
      headers: [
        { label: 'ID de proyecto', property: 'id' },
        {
          label: 'Tipo de proyecto',
          property: 'proyectType',
        },
        { label: 'Nombre cliente', property: 'client' },
        { label: 'Estado del proyecto', property: 'status' },
        { label: 'Vendedor', property: 'vendor' },
        { label: 'Inspector', property: 'inspector' },
        { label: 'Instalador', property: 'instalator' },
        { label: 'Fecha de inicio', property: 'createdAt' },
        { label: 'Días activos', property: 'activeDays' },
        { label: 'Observaciones', property: 'observations' },
      ],
      datas,
    };

    await doc.table(table, {
      prepareHeader: () => doc.fontSize(8),
      prepareRow: (row, indexColumn, indexRow, rectRow, rectCell) => {
        doc.fontSize(8);
        indexColumn === 0 && doc.addBackground(rectRow, 'white', 0.15);
      },
    });
  }

  async reportRejectedTable(doc: any, reportPDFDto: ReportPDFDto) {
    const { data } = await this.requestPetitionService.getRejected(
      reportPDFDto,
    );
    const datas = exportRejectedPetitionParserMap(data);
    const table = {
      headers: [
        { label: 'ID de proyecto', property: 'id' },
        {
          label: 'Tipo de proyecto',
          property: 'proyectType',
        },
        { label: 'Nombre cliente', property: 'client' },
        { label: 'Estado del proyecto', property: 'status' },
        { label: 'Vendedor', property: 'vendor' },
        { label: 'Inspector', property: 'inspector' },
        { label: 'Instalador', property: 'instalator' },
        { label: 'Fecha de inicio', property: 'createdAt' },
        { label: 'Fecha de finalización', property: 'finishDate' },
        { label: 'Observaciones', property: 'observations' },
      ],
      datas,
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
