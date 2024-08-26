export const GENERAL_ROUTES = {
  system: 'system/',
  user: 'user/'
}

export const SPECIFIC_ROUTES = {
  driverDocuments: `${GENERAL_ROUTES.system}driverDocuments/`,
  vehiclesDocuments: `${GENERAL_ROUTES.system}vehiclesDocuments/`,
  advertisingDocuments: `${GENERAL_ROUTES.system}advertisingDocuments/`
}

export const SPECIFIC_ROUTES_USERS = {
  driverDocuments: 'driverDocuments/',
  vehiclesDocuments: 'vehiclesDocuments/'
}

export const SPECIFIC_ROUTES_SYSTEM = {
  driverManual: 'driverManualDocuments/',
  customerManual: 'customerManualDocuments/'
}

export const SPECIFIC_ROUTES_IMAGES_DEFAULT = {
  companyImageDefault: 'https://firebasestorage.googleapis.com/v0/b/mikmic-3a9c2.appspot.com/o/system%2FLogo.png?alt=media&token=01d40ed2-d84f-49fc-996b-db7dd7d2a478'
}
