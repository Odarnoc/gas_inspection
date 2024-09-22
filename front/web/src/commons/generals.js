
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

export const manualsUrl = {
  driver: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FstaticDocuments%2FManual%20de%20usuario%20conductor%201.0.29.pdf?alt=media&token=22e83d03-34f7-4a35-ad9d-1faa7744c912',
  client: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FstaticDocuments%2FManual%20de%20usuario%20cliente%201.0.29.pdf?alt=media&token=971a8a78-312f-4a10-9ccc-db8077cdbc59',
  documentUpload: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FstaticDocuments%2FGuia%20carga%20documentos.pdf?alt=media&token=a5dfb342-1ca0-47c9-90f8-c7acaa0e2c62',
  vehicleRegister: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FstaticDocuments%2FGuia%20carga%20vehiculos.pdf?alt=media&token=ab723f34-8242-443a-a241-b2a9b9a1cefd',
  vehicleDocumnets: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FstaticDocuments%2FCarga%20de%20documentos%20de%20veh%C3%ADculo.pdf?alt=media&token=c2850188-a902-445a-993e-747f40e3378d'
}
