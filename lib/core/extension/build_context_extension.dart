library build_context_extension;

import 'package:flutter/widgets.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/presentation/localization/app_localizations.dart';

extension TranslationsExtension on BuildContext {
  String translateKey(String key) =>
      AppLocalizations.of(this).translateKey(key);

  String translate(RawKeyString rawKeyString) =>
      AppLocalizations.of(this).translate(rawKeyString);
}
