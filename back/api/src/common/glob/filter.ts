import 'dotenv/config';
import { TypesEnviroment } from './types';

export const FilterMeters = {
  DELIVERYMAN: process.env.ENV_TYPE != TypesEnviroment.PROD ? 90000000 : 105000,
  // DELIVERYMAN = 90000000,

  STORES_NEARBY: 80000000,
};

export enum FilterTimesOnMs {
  // CANCEL_ORDER = 20000, // ten seconds
  CANCEL_ORDER = 600000, // ten minutes
}
