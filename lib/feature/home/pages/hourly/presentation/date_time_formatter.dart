import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class DateTimeFormatter {
  static const defaultDatePattern = 'dd-MM-yyyy';
  static const networkDatePattern = 'yyyy-MM-dd';
  static const defaultHourPattern = 'HH:mm';

  DateTimeFormatter();

  String format(DateTime date, String pattern) =>
      DateFormat(pattern).format(date);
}
