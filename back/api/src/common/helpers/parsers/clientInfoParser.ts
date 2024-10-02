import { RequestPetition } from '../../../vendor/requests/entities/requestPetition.entity';
export function clientPDFParser(request: RequestPetition) {
  return {
    fullName: `${request.firstName} ${request.paternalName} ${request.maternalName}`,
    ci: request.ci,
    proyectType: request.proyectType.name,
    phones: `${request.phone} / ${request.cellphone}`,
    address: `${request.zone} ${request.avenue} ${request.street} Nro. ${request.door}`,
  };
}

export function techPDFParser(request: RequestPetition) {
  return {
    minimumVolume: request.minimumVolume ? 'SI' : 'NO',
    airSupply: request.airSupply ? 'SI' : 'NO',
    airOutlet: request.airOutlet ? 'SI' : 'NO',
    rapidAeration: request.rapidAeration ? 'SI' : 'NO',
    pressureCheck: request.pressureCheck ? 'SI' : 'NO',
    valvuleCheck: request.valvuleCheck ? 'SI' : 'NO',
    leakCheck: request.leakCheck ? 'SI' : 'NO',
    ventilation: request.ventilation ? 'SI' : 'NO',
    areaCleaning: request.areaCleaning ? 'SI' : 'NO',
  };
}
