import { HttpService } from '@nestjs/axios';
import { Injectable } from '@nestjs/common';
import { firstValueFrom } from 'rxjs';

@Injectable()
export class GeocoderService {
  constructor(private readonly httpService: HttpService) {}

  async generateRoute(origin, destination) {
    const queryParameters = {
      geometries: 'geojson',
      alternatives: true,
      steps: true,
      overview: false,
    };
    return firstValueFrom(
      this.httpService.get(
        `https://routing.openstreetmap.de/routed-car/route/v1/driving/${origin.y},${origin.x};${destination.y},${destination.x}`,
        {
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept-Language': 'es',
          },
          params: queryParameters,
        },
      ),
    );
  }
}
