import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { TypeOrmModule } from '@nestjs/typeorm';

import { CommonModule } from './common/common.module';
import { AuthModule } from './auth/auth.module';

import {
  I18nModule,
  HeaderResolver,
  AcceptLanguageResolver,
  QueryResolver,
} from 'nestjs-i18n';
import { join } from 'path';
import { ProyectTypeModule } from './admin/proyectType/proyectType.module';
import { RequestPetitionModule } from './vendor/requests/requestPetition.module';
import { RequestDocumentsModule } from './vendor/requestDocuments/requestDocuments.module';
import { RequestPetitionLogsModule } from './log/request-petition/request-petition-logs.module';
import { CovergeLinesModule } from './admin/coverage-map/covergeLines.module';
import { RequestMaterialsModule } from './vendor/requestMaterials/requestMaterials.module';
import { PdfModule } from './pdf/pdf.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: +process.env.DB_PORT,
      username: process.env.DB_USERNAME,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      entities: [],
      autoLoadEntities: true,
      synchronize: true,
    }),
    I18nModule.forRootAsync({
      useFactory: () => ({
        fallbackLanguage: 'es',
        loaderOptions: {
          path: join(__dirname, 'i18n'),
          watch: true,
        },
      }),
      resolvers: [
        { use: QueryResolver, options: ['lang'] },
        AcceptLanguageResolver,
        new HeaderResolver(['x-lang']),
      ],
    }),
    CommonModule,
    AuthModule,
    ProyectTypeModule,
    RequestPetitionModule,
    RequestDocumentsModule,
    RequestPetitionLogsModule,
    CovergeLinesModule,
    RequestMaterialsModule,
    PdfModule,
  ],
  providers: [],
})
export class AppModule {}
