export function polygonCordinatesToLatLongParser(polygon: number[][]) {
  return polygon.map((geometry) =>
    geometry.map((coordinates) => ({
      lat: coordinates[1],
      lng: coordinates[0],
    })),
  );
}
