import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/model/connect_to_wifi_result/connect_to_wifi_result_model.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';

@lazySingleton
class ConnectToWifiEntityConverter
    implements Converter<ConnectToWifiResultModel, ConnectToWifiResult> {
  @override
  // ignore: missing_return
  ConnectToWifiResult convert(ConnectToWifiResultModel model) {
    switch (model) {
      case ConnectToWifiResultModel.connected:
        return const ConnectToWifiResult.connected();
      case ConnectToWifiResultModel.error:
        return const ConnectToWifiResult.error();
    }
  }
}
