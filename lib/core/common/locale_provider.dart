import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocaleProvider {
  Locale get currentLocale => AutoLocalization.instance.locale;
}
