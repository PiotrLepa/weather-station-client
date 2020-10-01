import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/extension/iterable_extension.dart';
import 'package:weather_station/domain/utils/arduino_configurator/exception/device_connection_exception.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi_name/wifi_name.dart';

@lazySingleton
class ArduinoConfigurator {
  static const deviceBleName = 'ESP-32 WeatherStation';
  static const serviceUuid = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
  static const characteristicUuid = 'beb5483e-36e1-4688-b7f5-ea07361b26a8';

  final BleManager _bleManager;

  Peripheral device;

  ArduinoConfigurator(this._bleManager);

  Future<void> setupBleManager() async {
    return _bleManager
        .createClient()
        .then((_) => _checkPermissions())
        .then((_) => _enableBluetooth())
        .then((_) => _scanForDevice())
        .then((device) => device.connect().then((_) => device))
        .then((device) => device.discoverAllServicesAndCharacteristics())
        .catchError(
          (dynamic e) => Future<DeviceConnectionException>.error(
            e is DeviceConnectionException
                ? e
                : const DeviceConnectionException.unknown(),
          ),
        );
  }

  Future<KtList<WifiName>> getAvailableWifiList() {
    return device
        .readCharacteristic(serviceUuid, characteristicUuid)
        .then((characteristics) {
      final string = _decode(characteristics.value);
      final list = json.decode(string) as Iterable<dynamic>;
      return list
          .map((dynamic value) =>
              WifiName.fromJson(value as Map<String, dynamic>))
          .toKtList();
    });
  }

  Future<void> sendWifiCredentials(WifiCredentials wifi) {
    return device.writeCharacteristic(
      serviceUuid,
      characteristicUuid,
      _encode(json.encode(wifi.toJson())),
      true,
    );
  }

  Future<void> close() async {
    await device?.disconnectOrCancelConnection();
    await _bleManager.stopPeripheralScan();
    await _bleManager.destroyClient();
  }

  Uint8List _encode(String value) => Uint8List.fromList(utf8.encode(value));

  String _decode(Uint8List value) => utf8.decode(value);

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.locationWhenInUse.request();

      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        return Future.error(
          const DeviceConnectionException.permissionPermanentlyDenied(),
        );
      } else if (permissionStatus != PermissionStatus.granted) {
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
    final completer = Completer<Peripheral>();
    StreamSubscription<ScanResult> scan;
    scan =
        _bleManager.startPeripheralScan(scanMode: ScanMode.lowLatency).listen(
      (ScanResult scanResult) async {
        final peripheral = scanResult.peripheral;
        if (peripheral.name == deviceBleName) {
          scan.cancel();
          device = peripheral;
          await _bleManager.stopPeripheralScan();
          completer.complete(peripheral);
        }
      },
    );
    return completer.future;
  }
}
