import 'dart:async';
import 'dart:io';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';
import 'package:weather_station/domain/entity/station_exception/station_exception.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/repository/station_repository.dart';

@injectable
class StationConfigurator {
  final StationRepository _stationRepository;

  Peripheral _device;

  StationConfigurator(this._stationRepository);

  Future<void> connect() async {
    _device =
        await _checkPermissions().then((_) => _stationRepository.connect());
  }

  Future<KtList<Wifi>> getAvailableWifiList() {
    return _connectIfDisconnected()
        .then((_) => _stationRepository.observeWifiList(_device).first);
  }

  Future<ConnectToWifiResult> sendWifiCredentials(
    WifiCredentials wifiCredentials,
  ) async {
    return _connectIfDisconnected()
        .then((_) => _stationRepository.observeConnectToWifiResult(_device))
        .then(
      (connectionResult) async {
        final result = connectionResult.first;

        // give time to start observe connect to wifi result
        await Future<void>.delayed(const Duration(seconds: 1)).then((_) =>
            _stationRepository.sendWifiCredentials(_device, wifiCredentials));

        return result;
      },
    );
  }

  Future<void> close() {
    return _stationRepository.close(_device);
  }

  Future<void> disconnectAndCancelOperations() async {
    return _stationRepository.disconnectAndCancelOperations(_device);
  }

  Future<void> _connectIfDisconnected() async {
    final isConnected = _device != null && await _device.isConnected();
    if (!isConnected) {
      await connect();
    }
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
