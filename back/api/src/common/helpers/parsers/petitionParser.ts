import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import { getDaysBetwen, toUSADate } from '../reportsHelpers';
import { StatusOrder } from 'src/common/glob/status';

export function exportRejectedPetitionParserMap(items: RequestPetition[]) {
  return items.map((item) => ({
    id: item.id,
    proyectType: item.proyectType.name,
    client: `${item.firstName} ${item.paternalName} ${item.maternalName}`,
    status: parsestatus(item.status),
    vendor: `${item.vendor?.firstName ?? ''} ${
      item.vendor?.paternalName ?? ''
    } ${item.vendor?.maternalName ?? ''}`,
    inspector: `${item.inspector?.firstName ?? ''} ${
      item.inspector?.paternalName ?? ''
    } ${item.inspector?.maternalName ?? ''}`,
    instalator: `${item.instalator?.firstName ?? ''} ${
      item.instalator?.paternalName ?? ''
    } ${item.instalator?.maternalName ?? ''}`,
    createdAt: toUSADate(item.createdAt),
    finishDate: toUSADate(item.finishDate),
    activeDays: getDaysBetwen(item.createdAt, new Date()),
    observations: item.observations,
  }));
}

export function parsestatus(status: number) {
  console.log(status === StatusOrder.assigned);
  if (status === StatusOrder.assigned) {
    return 'Asignada para inspección';
  }
  if (status === StatusOrder.observed) {
    return 'Observada';
  }
  if (status === StatusOrder.inspectionAproved) {
    return 'Inspección aprobada';
  }
  if (status === StatusOrder.instalationAssigned) {
    return 'Asignada para instalación';
  }
  if (status === StatusOrder.instalationReassigned) {
    return 'Reasignada para instalación';
  }
  if (status === StatusOrder.interrnalInspection) {
    return 'Solicitud de inspección interna';
  }
  if (status === StatusOrder.done) {
    return 'Solicitud finalizada';
  }
  if (status === StatusOrder.store) {
    return 'Solicitud archivada';
  }
  if (status === StatusOrder.rejected) {
    return 'Inspección rechazada';
  }

  return 'Uknown';
}
