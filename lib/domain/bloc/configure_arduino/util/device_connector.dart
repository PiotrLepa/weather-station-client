import 'dart:async';
import 'dart:io';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connection_exception.dart';

@lazySingleton
class DeviceConnector {
  static const deviceBleName = 'ESP-32 WeatherStation';

  final BleManager _bleManager;

  Peripheral device;

  DeviceConnector(this._bleManager);

  Future<void> setupBleManager() async {
    return _bleManager
        .createClient()
        .then((_) => _checkPermissions())
        .then((_) => _enableBluetooth())
        .then((_) => _scanForDevice())
        .then((peripheral) => peripheral.connect())
        .catchError(
          (dynamic _) => Future<DeviceConnectionException>.error(
            const DeviceConnectionException.unknown(),
          ),
        );
  }

  Future<void> close() async {
    await device?.disconnectOrCancelConnection();
    await _bleManager.stopPeripheralScan();
    await _bleManager.destroyClient();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.locationWhenInUse.request();

      if (permissionStatus != PermissionStatus.granted) {
        return Future.error(
          const DeviceConnectionException.permissionNotGranted(),
        );
      }
    }
  }

  Future<void> _enableBluetooth() async {
    if (await _bleManager.bluetoothState() != BluetoothState.POWERED_ON) {
      await _bleManager.enableRadio();
    }
  }

  Future<Peripheral> _scanForDevice() {
    return _bleManager
        .startPeripheralScan(scanMode: ScanMode.lowLatency)
        .firstWhere((scanResult) => scanResult.peripheral.name == deviceBleName)
        .then((scanResult) {
      device = scanResult.peripheral;
      return scanResult.peripheral;
    });
  }

// Future<Peripheral> _scanForDevice() {
//   final device = Completer<Peripheral>();
//   StreamSubscription<ScanResult> scan;
//   scan = _bleManager
//       .startPeripheralScan(scanMode: ScanMode.lowLatency)
//       .listen((ScanResult scanResult) async {
//     final peripheral = scanResult.peripheral;
//     if (peripheral.name == deviceBleName) {
//       scan.cancel();
//       _device = peripheral;
//       await _bleManager.stopPeripheralScan();
//       device.complete(peripheral);
//     }
//   });
//   return device.future;
// }
}
