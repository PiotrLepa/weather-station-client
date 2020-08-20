import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

@lazySingleton
class Validator {
  static final emailRegex = RegExp(
      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

  RawKeyString validateUsername(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length < 3) {
      return KeyString('usernameTooShortError');
    } else {
      return null;
    }
  }

  RawKeyString validateEmail(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (!emailRegex.hasMatch(value)) {
      return KeyString('invalidEmailError');
    } else {
      return null;
    }
  }

  RawKeyString validatePassword(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length < 6) {
      return KeyString('passwordTooShortError');
    } else {
      return null;
    }
  }

  RawKeyString validateOpponentCode(String value) {
    if (value.isEmpty) {
      return KeyString('emptyFieldError');
    } else if (value.length != 8) {
      return KeyString('opponentCodeLengthError');
    } else {
      return null;
    }
  }
}
