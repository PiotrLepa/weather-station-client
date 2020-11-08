import 'package:injectable/injectable.dart';

@lazySingleton
class DateTimeParser {
  DateTime fromNetwork(String dateToParse) {
    return DateTime.parse('${dateToParse}Z').toLocal();
  }
}
