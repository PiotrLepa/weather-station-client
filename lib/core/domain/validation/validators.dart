import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

@lazySingleton
class Validator {
  static final emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  RKString validateUsername(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length < 3) {
      return KeyString('usernameTooShortError');
    } else {
      return null;
    }
  }

  RKString validateEmail(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (!emailRegex.hasMatch(value)) {
      return KeyString('invalidEmailError');
    } else {
      return null;
    }
  }

  RKString validatePassword(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length < 6) {
      return KeyString('passwordTooShortError');
    } else {
      return null;
    }
  }

  RKString validateOpponentCode(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length != 8) {
      return KeyString('opponentCodeLengthError');
    } else {
      return null;
    }
  }
}
