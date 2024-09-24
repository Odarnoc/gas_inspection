
const generals = {
  pagination: {
    rowsPerPage: 10
  },
  rowsOptions: [10, 50, 200, 500, 0]
}

export default generals

export const accepteFiles = {
  images: '.jpg,.jpeg,.png'
}

export const sizeFiles = 10485760

export const orderTypeIds = {
  normal: 1,
  manual: 2,
  office: 3
}

export const markerKeys = {
  origin: 'originMarker',
  destination: 'destinationMarker'
}

export const markerColors = {
  origin: '#21ba45',
  destination: '#f44336'
}

export const imageCompressionType = {
  b64: 'b64',
  blob: 'blob'
}

export const precentRange = {
  min: 0,
  max: 100
}
