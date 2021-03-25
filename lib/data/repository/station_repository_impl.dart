import 'dart:convert';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/data/network/error_handler/ble_error_handler.dart';
import 'package:weather_station/data/converter/entity/connect_to_wifi_converter.dart';
import 'package:weather_station/data/converter/entity/wifi_converter.dart';
import 'package:weather_station/data/service/ble_service.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/repository/station_repository.dart';

@LazySingleton(as: StationRepository)
class StationRepositoryImpl extends StationRepository {
  static const _deviceName = 'ESP-32 WeatherStation';
  static const _service = 'a386aa2b-ce06-460c-bd02-9743997288b2';
  static const _startScanCharacteristic =
      '53ce635f-255d-4cdb-9ece-dc8ba92180aa';
  static const _wifiListCharacteristic = 'db7a9839-79a5-455f-a213-736f25691050';
  static const _connectToWifiResultCharacteristic =
      'e5b9a6f3-2d49-447b-a924-b2d116ca8e3f';

  final BleService _bleService;
  final WifiConverter _wifiEntityConverter;
  final ConnectToWifiConverter _connectToWifiConverter;

  StationRepositoryImpl(
    this._bleService,
    this._wifiEntityConverter,
    this._connectToWifiConverter,
  );

  @override
  Future<Peripheral> connect() {
    return _bleService.connect(_deviceName).handleBleError();
  }

  @override
  Stream<KtList<Wifi>> observeWifiList(Peripheral device) async* {
    await _bleService
        .readCharacteristic(
          device: device,
          serviceUuid: _service,
          characteristicUuid: _startScanCharacteristic,
        )
        .handleBleError();

    yield* _bleService
        .observeWifiList(
          device: device,
          serviceUuid: _service,
          characteristicUuid: _wifiListCharacteristic,
        )
        .map((wifiList) => wifiList.map(_wifiEntityConverter.toEntity))
        .mapAndRethrowBleError();
  }

  @override
  Stream<ConnectToWifiResult> observeConnectToWifiResult(
      Peripheral device) async* {
    yield* _bleService
        .observeConnectToWifiResult(
          device: device,
          serviceUuid: _service,
          characteristicUuid: _connectToWifiResultCharacteristic,
        )
        .map(_connectToWifiConverter.toEntity)
        .mapAndRethrowBleError();
  }

  @override
  Future<void> sendWifiCredentials(
    Peripheral device,
    WifiCredentials wifiCredentials,
  ) {
    return _bleService
        .writeCharacteristic(
          value: json.encode(wifiCredentials.toJson()),
          device: device,
          serviceUuid: _service,
          characteristicUuid: _wifiListCharacteristic,
        )
        .handleBleError();
  }

  @override
  Future<void> disconnectAndCancelOperations(Peripheral device) {
    return _bleService.disconnectAndCancelOperations(device).handleBleError();
  }

  @override
  Future<void> close(Peripheral device) {
    return _bleService.close(device).handleBleError();
  }
}
