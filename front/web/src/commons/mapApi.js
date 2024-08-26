import axios from 'axios'

const headersList = {
  'Content-Type': 'application/json; charset=UTF-8',
  Accept: '*/*'
}
const nominatimInstance = axios.create({
  baseURL: 'https://nominatim.openstreetmap.org/',
  headers: headersList
})

const osmInstance = axios.create({
  baseURL: 'https://routing.openstreetmap.de/',
  headers: headersList
})

const mapApi = {
  geocoding: (searchText) => nominatimInstance.get('search', {
    params: {
      q: searchText,
      format: 'json'
      // countrycodes: 'mx'
    }
  }),
  reverseGeocoding: (lat, lon) => nominatimInstance.get('reverse', {
    params: {
      lat,
      lon,
      format: 'json'
    }
  }),
  generateRoute: (origin, destination) => osmInstance.get(`routed-car/route/v1/driving/${origin.lon},${origin.lat};${destination.lon},${destination.lat}`, {
    params: {
      geometries: 'geojson',
      alternatives: 'true',
      steps: 'true',
      overview: 'full'
    }
  })
}

export default mapApi
