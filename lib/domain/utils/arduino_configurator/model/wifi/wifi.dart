import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi/wifi_encryption.dart';

part 'wifi.freezed.dart';

part 'wifi.g.dart';

@freezed
abstract class Wifi with _$Wifi {
  const factory Wifi({
    @required String name,
    @required WifiEncryption encryption,
    @required int rssi,
  }) = _Wifi;

  factory Wifi.fromJson(Map<String, dynamic> json) => _$WifiFromJson(json);
  static const fromJsonFactory = _$WifiFromJson;
}
