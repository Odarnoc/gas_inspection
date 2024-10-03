import { RequestPetition } from 'src/vendor/requests/entities/requestPetition.entity';
import { getDaysBetwen, toUSADate } from '../reportsHelpers';

export function exportRejectedPetitionParserMap(items: RequestPetition[]) {
  return items.map((item) => ({
    id: item.id,
    proyectType: item.proyectType.name,
    client: `${item.firstName} ${item.paternalName} ${item.maternalName}`,
    status: item.status,
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
