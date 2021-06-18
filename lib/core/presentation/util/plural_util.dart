import 'dart:math';

import 'package:auto_localized/auto_localized.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PluralUtil {
  PlainLocalizedString applyPlurals({
    required int quantity,
    required PlainLocalizedString one,
    required PlainLocalizedString few,
    required PlainLocalizedString many,
  }) {
    final lastDigit = (quantity % 10).abs();
    if (lastDigit >= 2 && lastDigit <= 4) {
      return few;
    } else if (quantity >= 21 && lastDigit == 1) {
      return many;
    }
    return _getPluralRecursive(
      quantity: quantity,
      one: one,
      few: few,
      many: many,
    );
  }

  PlainLocalizedString _getPluralRecursive({
    required int quantity,
    required PlainLocalizedString many,
    required PlainLocalizedString one,
    required PlainLocalizedString few,
  }) {
    if (quantity == 0) {
      return many;
    } else if (quantity == 1) {
      return one;
    } else if (quantity >= 2 && quantity <= 4) {
      return few;
    } else if (quantity >= 5 && quantity <= 19) {
      return many;
    } else {
      final numberWithoutLastDigit = _removeLastDigit(quantity.abs());
      return _getPluralRecursive(
        quantity: numberWithoutLastDigit,
        one: one,
        few: few,
        many: many,
      );
    }
  }

  int _removeLastDigit(int number) {
    final log10 = log(number) / ln10;
    return number % pow(10, log10.toInt()).toInt();
  }
}
