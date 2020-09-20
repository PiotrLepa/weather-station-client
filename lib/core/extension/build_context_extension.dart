library build_context_extension;

import 'package:flutter/widgets.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/presentation/localization/app_localizations.dart';

extension TranslationsExtension on BuildContext {
  String translateKey(String key) {
    if (key != null) {
      return AppLocalizations.of(this).translateKey(key);
    } else {
      return null;
    }
  }

  String translate(RKString string) {
    if (string != null) {
      return AppLocalizations.of(this).translate(string);
    } else {
      return null;
    }
  }
}
