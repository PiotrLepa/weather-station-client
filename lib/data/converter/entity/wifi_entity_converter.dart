import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/model/wifi/wifi_model.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

@lazySingleton
class WifiEntityConverter implements Converter<WifiModel, Wifi> {
  @override
  Wifi convert(WifiModel model) => Wifi(
        name: model.name,
        encryption: model.encryption,
        rssi: model.rssi,
      );
}
