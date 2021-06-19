import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/domain/entity/signal_strength/signal_strength.dart';
import 'package:weather_station/domain/entity/wifi_encryption/wifi_encryption.dart';

part 'wifi.freezed.dart';

@freezed
class Wifi with _$Wifi {
  const factory Wifi({
    required String name,
    required WifiEncryption encryption,
    required SignalStrength signalStrength,
  }) = _Wifi;
}
