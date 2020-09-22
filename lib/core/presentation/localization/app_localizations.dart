import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/common/locale_provider.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/injection/injection.dart';

class AppLocalizations {
  final Locale locale;
  final LocaleProvider _localeProvider;

  Map<String, String> _localizedStrings;

  AppLocalizations(this.locale, this._localeProvider) {
    _localeProvider.currentLocale = locale;
  }

  Future load() async {
    final jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
    final decodedMap = jsonMap.cast<String, String>();

    _localizedStrings =
        decodedMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(RKString rawKeyString) =>
      rawKeyString.get(_localizedStrings);

  String translateKey(String key) => _localizedStrings[key];

  static LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final LocaleProvider _localeProvider = getIt.get<LocaleProvider>();

  _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      _localeProvider.getSupportedLocales().contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale, _localeProvider);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
