import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/data/service/ble_service.dart';
import 'package:weather_station/domain/repository/arduino_repository.dart';
import 'package:weather_station/domain/utils/arduino_configurator/exception/device_connection_exception.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi/wifi.dart';

@LazySingleton(as: ArduinoRepository)
class ArduinoRepositoryImpl extends ArduinoRepository {
  static const _deviceName = 'ESP-32 WeatherStation';
  static const _service = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
  static const _startScanCharacteristic =
      '53ce635f-255d-4cdb-9ece-dc8ba92180aa';
  static const _wifiListCharacteristic = 'db7a9839-79a5-455f-a213-736f25691050';

  final BleService _bleService;

  ArduinoRepositoryImpl(this._bleService);

  @override
  Future<Peripheral> connect() {
    return _bleService.connect(_deviceName).catchError(_handleFutureError);
  }

  @override
  Stream<KtList<Wifi>> observeWifiList(Peripheral device) async* {
    await _bleService
        .readCharacteristic(
          device: device,
          serviceUuid: _service,
          characteristicUuid: _startScanCharacteristic,
        )
        .catchError(_handleFutureError);

    yield* _bleService
        .observeWifiList(
          device: device,
          serviceUuid: _service,
          characteristicUuid: _wifiListCharacteristic,
        )
        .handleError((Object e) => throw _mapError(e));
  }

  @override
  Future<void> disconnectAndCancelOperations(Peripheral device) {
    return _bleService
        .disconnectAndCancelOperations(device)
        .catchError(_handleFutureError);
  }

  @override
  Future<void> close(Peripheral device) {
    return _bleService.close(device).catchError(_handleFutureError);
  }

  Future<DeviceConnectionException> _handleFutureError(Object error) {
    return Future<DeviceConnectionException>.error(_mapError(error));
  }

  DeviceConnectionException _mapError(Object error) {
    return error is DeviceConnectionException
        ? error
        : const DeviceConnectionException.unknown();
  }
}
