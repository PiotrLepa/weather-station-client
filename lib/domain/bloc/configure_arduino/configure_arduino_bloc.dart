import 'dart:async';
import 'dart:io';

import 'package:async/async.dart' show StreamGroup;
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/configure_arduino_connecting_images.dart';
import 'package:weather_station/gen/assets.gen.dart';

part 'configure_arduino_bloc.freezed.dart';

part 'configure_arduino_event.dart';

part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends Bloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  static const arduinoBleName = 'ESP-32 WeatherStation';

  final FlushbarHelper _flushbarHelper;
  final BleManager _bleManager;

  Peripheral _device;

  ConfigureArduinoBloc(this._flushbarHelper, this._bleManager)
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
    await _device?.disconnectOrCancelConnection();
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
        .then((_) => _checkPermissions())
        .catchError((dynamic _) =>
        _flushbarHelper.showError(
            message: Strings.connectToDeviceError)) // TODO error screen
        .then((_) => _enableBluetooth())
        .then((_) => _scanForDevice())
        .then((peripheral) => peripheral.connect())
        .then((_) => const ConfigureArduinoState.renderWifiInputs())
        .catchError((dynamic _) =>
        _flushbarHelper.showError(message: Strings.connectToDeviceError));
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      final permissionStatus = await Permission.locationWhenInUse.request();

      if (permissionStatus != PermissionStatus.granted) {
        return Future.error(Exception("Location permission not granted"));
      }
    }
  }

  Future<void> _enableBluetooth() async {
    if (await _bleManager.bluetoothState() != BluetoothState.POWERED_ON) {
      await _bleManager.enableRadio();
    }
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
