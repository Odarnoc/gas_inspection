import { CovergeLines } from '../../../admin/coverage-map/entities/covergeLines.entity';
export function polygonCordinatesToLatLongParser(polygon: number[][]) {
  return polygon.map((geometry) =>
    geometry.map((coordinates) => ({
      lat: coordinates[1],
      lng: coordinates[0],
    })),
  );
}

export function linesCordinatesToLatLngParser(coverageLines: CovergeLines[]) {
  return coverageLines.map((coverageLine) => {
    return {
      editable: false,
      ...coverageLine,
      line: coverageLine.line.coordinates.map((coordinates) => ({
        lat: coordinates[1],
        lng: coordinates[0],
      })),
    };
  });
}
