import 'package:injectable/injectable.dart';

@lazySingleton
class DateTimeParser {
  DateTime fromNetwork(String dateToParse) {
    final date = DateTime.parse(dateToParse).toLocal();
    return date.subtract(date.timeZoneOffset);
  }
}
