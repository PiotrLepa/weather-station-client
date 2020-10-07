import 'package:auto_localized/auto_localized.dart';
import 'package:weather_station/core/presentation/validation/validator.dart';

typedef ValidatorFunction = PlainLocalizedString Function(String value);

// ignore: avoid_classes_with_only_static_members
class Validators {
  Validators._();

  static ValidatorFunction get required => RequiredValidator().validate;

  static ValidatorFunction minLength(int length) =>
      LengthValidator(min: length).validate;

  static ValidatorFunction maxLength(int length) =>
      LengthValidator(max: length).validate;
}
