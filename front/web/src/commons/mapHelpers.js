export function getBoundingBoxFromPoint (point, pDistanceInMeters = 300) {
  const latRadian = degreesToRadians(point.lat)

  const degLatKm = 110.574235
  const degLongKm = 110.572833 * Math.cos(latRadian)
  const deltaLat = pDistanceInMeters / 1000.0 / degLatKm
  const deltaLong = pDistanceInMeters / 1000.0 / degLongKm

  const topLat = point.lat + deltaLat
  const bottomLat = point.lat - deltaLat
  const leftLng = point.lng - deltaLong
  const rightLng = point.lng + deltaLong

  const northWestCoords = {
    lat: topLat,
    lng: leftLng
  }
  const northEastCoords = {
    lat: topLat,
    lng: rightLng
  }
  const southWestCoords = {
    lat: bottomLat,
    lng: leftLng
  }
  const southEastCoords = {
    lat: bottomLat,
    lng: rightLng
  }

  const boundingBox = [
    northWestCoords,
    northEastCoords,
    southEastCoords,
    southWestCoords
  ]

  return boundingBox
}

export function degreesToRadians (degrees) {
  return +degrees * (Math.PI / 180)
}

export function latLngToLineParser (path) {
  return path.map((point) => {
    return [point.lng, point.lat]
  })
}
