export function toUSADate(dateToParse: Date) {
  console.log(dateToParse);
  if (!dateToParse) {
    return '';
  }
  return dateToParse.toLocaleDateString('en-GB');
}

export function getDaysBetwen(date1: Date, date2: Date) {
  if (!date1) {
    return '';
  }
  if (!date2) {
    return '';
  }
  const Difference_In_Time = date2.getTime() - date1.getTime();
  return Math.round(Difference_In_Time / (1000 * 3600 * 24));
}
