import 'package:injectable/injectable.dart';
import 'package:weather_station/data/converter/entity/wifi_encryption_converter.dart';
import 'package:weather_station/data/model/wifi/wifi_model.dart';
import 'package:weather_station/domain/entity/signal_strength/signal_strength.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

@lazySingleton
class WifiConverter {
  final WifiEncryptionConverter encryptionConverter;

  WifiConverter(this.encryptionConverter);

  Wifi toEntity(WifiModel model) => Wifi(
        name: model.name,
        encryption: encryptionConverter.toEntity(model.encryption),
        signalStrength: SignalStrength.fromRssi(model.rssi),
      );
}
