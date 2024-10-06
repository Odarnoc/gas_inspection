import * as dayjs from 'dayjs';

export function addDays(date, days) {
  date.setDate(date.getDate() + days);
  return date;
}

export function discountDays(date, days) {
  date.setDate(date.getDate() - days);
  return date;
}

export function toDBDate(dateToParse) {
  let info;
  if (dateToParse) {
    info = dateToParse.split('/').reverse().join('-');
  }
  return info;
}

export function addHours(date: Date, hours: number) {
  date.setTime(date.getTime() + hours * 60 * 60 * 1000);
  return date;
}

export function timeBetween(
  date: Date,
  startInMinutes: number,
  endInMinutes: number,
): boolean {
  const timeInMinutes = getTimeOfDayOnSeconds(
    date.getHours(),
    date.getMinutes(),
    date.getSeconds(),
  );
  return timeInMinutes >= startInMinutes && timeInMinutes < endInMinutes;
}

export function getTimeOfDayOnSeconds(
  hours: number,
  minutes: number,
  seconds: number,
) {
  const minutesInHour = 60;
  const secondsInMinute = 60;
  return (hours * minutesInHour + minutes) * secondsInMinute + seconds;
}

export function isDateExpirationTrue(date: Date) {
  const now = new Date();
  let response = true;
  if (date < now) {
    response = false;
  }
  return response;
}

export function isDateOnPast(date: Date) {
  const now = new Date();
  return date < now;
}

export function toKilometer(meters: number) {
  return (meters / 1000).toFixed(2);
}

export function toTimeConversion(seconds: number) {
  const hour = Math.floor(seconds / 3600);
  const minute = Math.floor((seconds / 60) % 60);
  const hourConvert = hour < 10 ? '0' + hour : hour;
  const minuteConvert = minute < 10 ? '0' + minute : minute;
  return hourConvert + ':' + minuteConvert;
}
