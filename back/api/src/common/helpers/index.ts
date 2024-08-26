export function roundUp(num, precision) {
  precision = Math.pow(10, precision);
  return Math.ceil(num * precision) / precision;
}

export function stringToObj(key: string, value: any) {
  let obj = {};
  const objectKeys = key.split('.') || [];
  let objectKey;
  while ((objectKey = objectKeys.pop())) {
    obj = {};
    obj[objectKey] = value;
    value = obj;
  }
  return obj;
}

export function getRandomBetween(min, max) {
  return Math.floor(Math.random() * (max - min) + min);
}
