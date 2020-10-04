import 'dart:async';
import 'dart:io';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/domain/entity/station_exception/station_exception.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/repository/station_repository.dart';

@lazySingleton
class StationConfigurator {
  final StationRepository _stationRepository;

  Peripheral _device;

  StationConfigurator(this._stationRepository);

  Future<void> connect() async {
    _device =
        await _checkPermissions().then((_) => _stationRepository.connect());
  }

  Stream<KtList<Wifi>> observeAvailableWifiList() {
    return _stationRepository.observeWifiList(_device);
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
    return _stationRepository.close(_device);
  }

  Future<void> disconnectAndCancelOperations() async {
    return _stationRepository.disconnectAndCancelOperations(_device);
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.locationWhenInUse.request();

      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        return Future.error(
          const StationException.permissionPermanentlyDenied(),
        );
      } else if (permissionStatus != PermissionStatus.granted) {
        return Future.error(
          const StationException.permissionNotGranted(),
        );
      }
    }
  }
}
