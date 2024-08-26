import { stringToObj } from './index';
export const getOrderBy = (orderField: string, descending: boolean) => {
  let order = {};
  if (orderField) {
    const orderType = getOrderType(descending);
    order = stringToObj(orderField, orderType);
  }
  return order;
};

export const getOrderType = (descending: boolean) => {
  return descending ? 'DESC' : 'ASC';
};
