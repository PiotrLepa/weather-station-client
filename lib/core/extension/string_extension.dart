import 'package:auto_localized/auto_localized.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';

extension LocalizedStringExtension on String {
  PlainLocalizedString toLocalized() {
    final localizedValue = AutoLocalizedData.supportedLocales.asMap().map(
          (key, value) => MapEntry(value.languageCode, this),
        );

    return PlainLocalizedString(
      key: this,
      values: localizedValue,
    );
  }
}
