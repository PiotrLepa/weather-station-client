import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/converter/entity/wifi_encryption_entity_converter.dart';
import 'package:weather_station/data/model/wifi/wifi_model.dart';
import 'package:weather_station/domain/entity/signal_strength/signal_strength.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

@lazySingleton
class WifiEntityConverter implements Converter<WifiModel, Wifi> {
  final WifiEncryptionEntityConverter encryptionConverter;

  WifiEntityConverter(this.encryptionConverter);

  @override
  Wifi convert(WifiModel model) => Wifi(
        name: model.name,
        encryption: encryptionConverter.convert(model.encryption),
        signalStrength: SignalStrength.fromRssi(model.rssi),
      );
}
