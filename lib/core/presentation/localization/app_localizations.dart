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
    final String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(RawKeyString rawKeyString) =>
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
    AppLocalizations localizations = AppLocalizations(locale, _localeProvider);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
