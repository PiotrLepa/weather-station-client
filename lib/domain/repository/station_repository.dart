import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

abstract class StationRepository {
  Future<Peripheral> connect();

  Future<void> disconnectAndCancelOperations(Peripheral device);

  Stream<KtList<Wifi>> observeWifiList(Peripheral device);

  Future<void> close(Peripheral device);
}
