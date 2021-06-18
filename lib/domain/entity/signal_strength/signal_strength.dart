import 'package:freezed_annotation/freezed_annotation.dart';

part 'signal_strength.freezed.dart';

@freezed
class SignalStrength with _$SignalStrength {
  const factory SignalStrength.excellent() = Excellent;

  const factory SignalStrength.strong() = Strong;

  const factory SignalStrength.fair() = Fair;

  const factory SignalStrength.weak() = Weak;

  static SignalStrength fromRssi(int rssi) {
    if (rssi > -73) {
      return const Excellent();
    } else if (rssi > -85) {
      return const Strong();
    } else if (rssi > -93) {
      return const Fair();
    } else {
      return const Weak();
    }
  }
}
