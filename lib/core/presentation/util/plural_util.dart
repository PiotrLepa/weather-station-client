import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

@lazySingleton
class PluralUtil {
  String applyPlurals({
    @required int quantity,
    @required String one,
    @required String few,
    @required String many,
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

  RKString applyPluralsRK({
    @required int quantity,
    @required RKString one,
    @required RKString few,
    @required RKString many,
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
      return applyPluralsRK(
        quantity: lastDigit,
        one: one,
        few: few,
        many: many,
      );
    }
  }
}
