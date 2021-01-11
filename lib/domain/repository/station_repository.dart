import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';

abstract class StationRepository {
  Future<Peripheral> connect();

  Stream<KtList<Wifi>> observeWifiList(Peripheral device);

  Stream<ConnectToWifiResult> observeConnectToWifiResult(Peripheral device);

  Future<void> sendWifiCredentials(
    Peripheral device,
    WifiCredentials wifiCredentials,
  );

  Future<void> disconnectAndCancelOperations(Peripheral device);

  Future<void> close(Peripheral device);
}
