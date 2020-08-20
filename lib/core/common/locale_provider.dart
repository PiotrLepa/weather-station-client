import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

@lazySingleton
class LocaleProvider {
  Locale currentLocale;

  KtList<Locale> getSupportedLocales() => KtList.of(
        const Locale('pl'),
      );

  KtList<String> getSupportedLanguageCodes() =>
      getSupportedLocales().map((locale) => locale.languageCode);
}
