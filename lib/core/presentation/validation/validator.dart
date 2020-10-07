import 'package:auto_localized/auto_localized.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';

abstract class Validator {
  PlainLocalizedString validate(String value);
}

class RequiredValidator extends Validator {
  @override
  PlainLocalizedString validate(String value) {
    if (value.trim().isEmpty) {
      return Strings.validationErrorRequired;
    }
    return null;
  }
}

class LengthValidator extends Validator {
  final int min;
  final int max;

  LengthValidator({this.min, this.max});

  @override
  PlainLocalizedString validate(String value) {
    if (min != null && value.length < min) {
      return Strings.validationErrorMinLength;
    } else if (max != null && value.length > max) {
      return Strings.validationErrorMaxLength;
    }
    return null;
  }
}
