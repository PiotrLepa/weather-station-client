import 'dart:async';
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/configure_arduino_connecting_images.dart';
import 'package:weather_station/gen/assets.gen.dart';

part 'configure_arduino_bloc.freezed.dart';

part 'configure_arduino_event.dart';

part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends Bloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  static const arduinoBleName = 'ESP-32 WeatherStation';

  final BleManager _bleManager;

  Peripheral _device;

  ConfigureArduinoBloc(this._bleManager)
      : super(ConfigureArduinoState.loading(getNextImage()));

  @override
  Stream<ConfigureArduinoState> mapEventToState(
    ConfigureArduinoEvent event,
  ) async* {
    yield* event.map(
      onScreenStarted: mapOnScreenStarted,
    );
  }

  @override
  Future<void> close() async {
    await _device.disconnectOrCancelConnection();
    await _bleManager.stopPeripheralScan();
    await _bleManager.destroyClient();
    return super.close();
  }

  Stream<ConfigureArduinoState> mapOnScreenStarted(
    OnScreenStarted event,
  ) async* {
    final imageStream = Stream<ConfigureArduinoState>.periodic(
      const Duration(seconds: 1),
      (_) => ConfigureArduinoState.loading(getNextImage()),
    );

    final mergedStates = StreamGroup.merge<ConfigureArduinoState>(
      [imageStream, _setupBleManager().asStream()],
    );
    await for (final newState in mergedStates) {
      yield newState;
      if (newState is RenderWifiInputs) {
        return;
      }
    }
  }

  Future<ConfigureArduinoState> _setupBleManager() async {
    return _bleManager
        .createClient()
        .then((value) => _checkPermissions())
        .catchError((dynamic e) => logger.d('Permission check error', e))
        .then((value) => _waitForBluetoothPoweredOn())
        .catchError((dynamic e) => logger.d('_waitForBluetoothPoweredOn', e))
        .then((value) => _scanForDevice())
        .catchError((dynamic e) => logger.d('_scanForDevice', e))
        .then((peripheral) => peripheral.connect())
        .catchError((dynamic e) => logger.d('connect', e))
        .then((value) {
      return const ConfigureArduinoState.renderWifiInputs();
    });
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.location.request();

      if (permissionStatus != PermissionStatus.granted) {
        return Future.error(Exception("Location permission not granted"));
      }
    }
  }

  Future<void> _waitForBluetoothPoweredOn() async {
    final completer = Completer<void>();
    StreamSubscription<BluetoothState> subscription;
    subscription = _bleManager.observeBluetoothState().listen(
      (bluetoothState) async {
        if (bluetoothState == BluetoothState.POWERED_ON &&
            !completer.isCompleted) {
          await subscription.cancel();
          completer.complete();
        }
      },
    );
    return completer.future;
  }

  Future<Peripheral> _scanForDevice() {
    final device = Completer<Peripheral>();
    StreamSubscription<ScanResult> scan;
    scan = _bleManager
        .startPeripheralScan(scanMode: ScanMode.lowLatency)
        .listen((ScanResult scanResult) async {
      final peripheral = scanResult.peripheral;
      if (peripheral.name == arduinoBleName) {
        scan.cancel();
        _device = peripheral;
        await _bleManager.stopPeripheralScan();
        device.complete(peripheral);
      }
    });
    return device.future;
  }
}
