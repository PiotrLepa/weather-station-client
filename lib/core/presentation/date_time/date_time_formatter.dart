import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:weather_station/core/common/locale_provider.dart';

@lazySingleton
class DateTimeFormatter {
  static const defaultDatePattern = 'dd-MM-yyyy';
  static const defaultHourPattern = 'HH:mm';

  final LocaleProvider localeProvider;

  DateTimeFormatter(
    this.localeProvider,
  );

  String format(DateTime date, String pattern) {
    return DateFormat(
      pattern,
      localeProvider.currentLocale.toLanguageTag(),
    ).format(date);
  }
}
