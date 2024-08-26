import 'package:intl/intl.dart';
import 'package:mikinder/constants/constants.dart';

parseDateTime(DateTime date) {
  return DateFormat(kMaskDateTime).format(date.toLocal());
}

parseDate(DateTime date) {
  return DateFormat(kMaskDate).format(date.toLocal());
}
