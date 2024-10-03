export function toUSADate(dateToParse: Date) {
  if (!dateToParse) {
    return '';
  }
  return dateToParse.toLocaleDateString('en-GB');
}

export function getDaysBetwen(date1: Date, date2: Date) {
  const Difference_In_Time = date2.getTime() - date1.getTime();
  return Math.round(Difference_In_Time / (1000 * 3600 * 24));
}
