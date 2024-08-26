import { IsLatitude, IsLongitude } from 'class-validator';

export class Location {
  @IsLatitude()
  x: number;

  @IsLongitude()
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}
export class Coordinates {
  @IsLatitude()
  latitude: number;

  @IsLongitude()
  longitude: number;

  constructor(latitude: number, longitude: number) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

export class GeocodeResponse {
  addressName: string;

  geometry: Location;

  constructor(addressName, geometry) {
    this.addressName = addressName;
    this.geometry = geometry;
  }
}
