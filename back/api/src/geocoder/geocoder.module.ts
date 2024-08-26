import { Module } from '@nestjs/common';
import { GeocoderService } from './geocoder.service';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [HttpModule],
  providers: [GeocoderService],
  exports: [GeocoderService],
})
export class GeocoderModule {}
