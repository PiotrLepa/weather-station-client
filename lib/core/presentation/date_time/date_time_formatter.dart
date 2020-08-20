import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:weather_station/core/common/locale_provider.dart';

@lazySingleton
class DateTimeFormatter {
  final LocaleProvider localeProvider;

  DateTimeFormatter(
    this.localeProvider,
  );

  String format(String date, String pattern) {
    final parsedDate = DateTime.parse(date).toLocal();
    return DateFormat(
      pattern,
      localeProvider.currentLocale.toLanguageTag(),
    ).format(parsedDate);
  }
}
