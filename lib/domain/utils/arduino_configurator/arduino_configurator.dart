import 'dart:async';
import 'dart:io';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/domain/entity/arduino_connection_exception/arduino_connection_exception.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/repository/arduino_repository.dart';

@lazySingleton
class ArduinoConfigurator {
  final ArduinoRepository _arduinoRepository;

  Peripheral _device;

  ArduinoConfigurator(this._arduinoRepository);

  Future<void> connect() async {
    _device =
        await _checkPermissions().then((_) => _arduinoRepository.connect());
  }

  Stream<KtList<Wifi>> observeAvailableWifiList() {
    return _arduinoRepository.observeWifiList(_device);
  }

  Future<void> sendWifiCredentials(WifiCredentials wifi) {
    // return _device.writeCharacteristic(
    //   serviceUuid,
    //   wifiListCharacteristicUuid,
    //   _encode(json.encode(wifi.toJson())),
    //   true,
    // );
  }

  Future<void> close() async {
    return _arduinoRepository.close(_device);
  }

  Future<void> disconnectAndCancelOperations() async {
    return _arduinoRepository.disconnectAndCancelOperations(_device);
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.locationWhenInUse.request();

      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        return Future.error(
          const ArduinoConnectionException.permissionPermanentlyDenied(),
        );
      } else if (permissionStatus != PermissionStatus.granted) {
        return Future.error(
          const ArduinoConnectionException.permissionNotGranted(),
        );
      }
    }
  }
}
