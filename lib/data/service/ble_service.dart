import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/iterable_extension.dart';
import 'package:weather_station/data/model/wifi/wifi_model.dart';

@lazySingleton
class BleService {
  final BleManager _bleManager;

  BleService(this._bleManager);

  Future<Peripheral> connect(String deviceName) {
    return _bleManager
        .createClient()
        .then((_) => _enableBluetooth())
        .then((_) => _scanForDevice(deviceName))
        .then((device) => device.connect().then((_) => device))
        .then(
      (device) async {
        await device.discoverAllServicesAndCharacteristics();
        return device;
      },
    );
  }

  Future<CharacteristicWithValue> readCharacteristic({
    @required Peripheral device,
    @required String serviceUuid,
    @required String characteristicUuid,
  }) {
    return device.readCharacteristic(serviceUuid, characteristicUuid);
  }

  Future<Characteristic> writeCharacteristic({
    @required String value,
    @required Peripheral device,
    @required String serviceUuid,
    @required String characteristicUuid,
  }) {
    return device.writeCharacteristic(
      serviceUuid,
      characteristicUuid,
      _encode(value),
      true,
    );
  }

  Stream<KtList<WifiModel>> observeWifiList({
    @required Peripheral device,
    @required String serviceUuid,
    @required String characteristicUuid,
  }) {
    String resultJson;

    final transformer =
        StreamTransformer<String, KtList<WifiModel>>.fromHandlers(
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

    return device
        .monitorCharacteristic(serviceUuid, characteristicUuid)
        .asyncMap(
            (_) => device.readCharacteristic(serviceUuid, characteristicUuid))
        .asyncMap((characteristic) => _decode(characteristic.value))
        .transform(transformer);
  }

  Uint8List _encode(String value) => Uint8List.fromList(utf8.encode(value));

  String _decode(Uint8List value) => utf8.decode(value);

  KtList<WifiModel> _parseWifiModel(String value) {
    if (value.isEmpty) {
      return const KtList.empty();
    }
    final list = json.decode(value) as Iterable<dynamic>;
    return list
        .map((dynamic value) =>
        WifiModel.fromJson(value as Map<String, dynamic>))
        .toKtList();
  }

  Future<void> disconnectAndCancelOperations(Peripheral device) async {
    if (device != null && await device.isConnected()) {
      await device.disconnectOrCancelConnection();
    }
    await _bleManager.stopPeripheralScan();
  }

  Future<void> close(Peripheral device) async {
    await disconnectAndCancelOperations(device);
    await _bleManager.destroyClient();
  }

  Future<Peripheral> _scanForDevice(String deviceName) {
    final completer = Completer<Peripheral>();
    StreamSubscription<ScanResult> scan;
    scan =
        _bleManager.startPeripheralScan(scanMode: ScanMode.lowLatency).listen(
      (ScanResult scanResult) async {
        final peripheral = scanResult.peripheral;
        if (peripheral.name == deviceName) {
          scan.cancel();
          await _bleManager.stopPeripheralScan();
          completer.complete(peripheral);
        }
      },
    );
    return completer.future;
  }

  Future<void> _enableBluetooth() async {
    if (await _bleManager.bluetoothState() != BluetoothState.POWERED_ON) {
      await _bleManager.enableRadio();
    }
  }
}
