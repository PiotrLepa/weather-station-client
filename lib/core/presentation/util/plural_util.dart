import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PluralUtil {
  PlainLocalizedString applyPlurals({
    @required int quantity,
    @required PlainLocalizedString one,
    @required PlainLocalizedString few,
    @required PlainLocalizedString many,
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
      final lastDigit = (quantity % 10).abs();
      return applyPlurals(
        quantity: lastDigit,
        one: one,
        few: few,
        many: many,
      );
    }
  }
}
