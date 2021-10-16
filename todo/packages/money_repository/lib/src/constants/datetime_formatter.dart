import 'package:intl/intl.dart';

class DatetimeFormatter {
  static String datetimeToDate(DateTime date, String format) {
    var formatter = DateFormat(format);
    return formatter.format(date);
  }
}
