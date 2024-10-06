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
    limitDate: toUSADate(new Date(`${item.limitDate}  00:00:00 -04`)),
    activeDays: getDaysBetwen(item.createdAt, new Date()),
    doneDays: getDaysBetwen(item.createdAt, item.finishDate),
    efectivity: parseEfectivity(item),
    observations: item.observations,
  }));
}

export function parsestatus(status: number) {
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

export function parseEfectivity(item: RequestPetition) {
  const estimatedDays = getDaysBetwen(
    item.createdAt,
    new Date(`${item.limitDate}  00:00:00 -04`),
  );
  const doneDays = getDaysBetwen(item.createdAt, item.finishDate);

  return doneDays > estimatedDays ? 'No efectiva' : 'Efectiva';
}
