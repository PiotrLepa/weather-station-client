import 'dart:math';

import 'package:injectable/injectable.dart';

@injectable
class PluralUtil {
  String applyPlurals({
    required int quantity,
    required String one,
    required String few,
    required String many,
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

  String _getPluralRecursive({
    required int quantity,
    required String many,
    required String one,
    required String few,
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
