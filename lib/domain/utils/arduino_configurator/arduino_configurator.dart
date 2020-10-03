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
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi/wifi.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi_credentials/wifi_credentials.dart';

@lazySingleton
class ArduinoConfigurator {
  static const deviceBleName = 'ESP-32 WeatherStation';
  static const serviceUuid = '4fafc201-1fb5-459e-8fcc-c5c9c331914b';
  static const startScanCharacteristicUuid =
      '53ce635f-255d-4cdb-9ece-dc8ba92180aa';
  static const wifiListCharacteristicUuid =
      'db7a9839-79a5-455f-a213-736f25691050';

  final BleManager _bleManager;

  Peripheral _device;

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
          (Object e) => Future<DeviceConnectionException>.error(_mapError(e)),
        );
  }

  var resultJson = "";

  Stream<KtList<Wifi>> observeAvailableWifiList() async* {
    await _device
        .readCharacteristic(serviceUuid, startScanCharacteristicUuid)
        .catchError(
          (Object e) => Future<DeviceConnectionException>.error(_mapError(e)),
        );

    final transformer = StreamTransformer<String, KtList<Wifi>>.fromHandlers(
      handleData: (json, sink) {
        if (json == 'start') {
          resultJson = '';
        } else if (json == 'end') {
          sink.add(_parseWifiModel(resultJson));
        } else {
          resultJson += json;
        }
      },
    );

    yield* _device
        .monitorCharacteristic(serviceUuid, wifiListCharacteristicUuid)
        .asyncMap((_) =>
            _device.readCharacteristic(serviceUuid, wifiListCharacteristicUuid))
        .asyncMap((characteristic) => _decode(characteristic.value))
        .transform(transformer)
        .handleError((Object e) => throw _mapError(e));
  }

  Future<void> sendWifiCredentials(WifiCredentials wifi) {
    return _device.writeCharacteristic(
      serviceUuid,
      wifiListCharacteristicUuid,
      _encode(json.encode(wifi.toJson())),
      true,
    );
  }

  Future<void> close() async {
    await disconnectAndCancelOperations();
    await _bleManager.destroyClient();
  }

  Future<void> disconnectAndCancelOperations() async {
    if (_device != null && await _device.isConnected()) {
      await _device.disconnectOrCancelConnection();
      _device = null;
    }
    await _bleManager.stopPeripheralScan();
  }

  DeviceConnectionException _mapError(Object error) {
    return error is DeviceConnectionException
        ? error
        : const DeviceConnectionException.unknown();
  }

  Uint8List _encode(String value) => Uint8List.fromList(utf8.encode(value));

  String _decode(Uint8List value) => utf8.decode(value);

  KtList<Wifi> _parseWifiModel(String value) {
    if (value.isEmpty) {
      return KtList.empty();
    }
    final list = json.decode(value) as Iterable<dynamic>;
    return list
        .map((dynamic value) => Wifi.fromJson(value as Map<String, dynamic>))
        .toKtList();
  }

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
          _device = peripheral;
          await _bleManager.stopPeripheralScan();
          completer.complete(peripheral);
        }
      },
    );
    return completer.future;
  }
}
