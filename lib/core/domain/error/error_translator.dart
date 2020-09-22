import 'package:auto_localized/auto_localized.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/extension/string_extension.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';

@lazySingleton
class ErrorTranslator {
  PlainLocalizedString translate(ApiException exception) {
    if (exception.printableMessage != null) {
      return exception.printableMessage.toLocalized();
    }
    return exception.map(
      noConnection: (_) => Strings.apiErrorNoConnection,
      badRequest: (_) => Strings.apiErrorBadRequest,
      notFound: (_) => Strings.apiErrorNotFound,
      internalServerError: (_) => Strings.apiErrorInternalServerError,
      unknownError: (_) => Strings.apiErrorUnknown,
    );
  }
}
