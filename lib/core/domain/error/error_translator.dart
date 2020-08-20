import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';

@lazySingleton
class ErrorTranslator {
  RawKeyString translate(ApiException exception) {
    if (exception.printableMessage != null) {
      return RawString(exception.printableMessage);
    }
    final keyString = exception.map(
      noConnection: (mappedState) => "apiErrorNoConnection",
      badRequest: (mappedState) => "apiErrorBadRequest",
      notFound: (mappedState) => "apiErrorNotFound",
      internalServerError: (mappedState) => "apiErrorInternalServerError",
      unknownError: (mappedState) => "apiErrorUnknown",
    );
    return KeyString(keyString);
  }
}
