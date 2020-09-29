import 'dart:async';

import 'package:auto_localized/auto_localized.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connection_exception.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connector.dart';

part 'configure_arduino_bloc.freezed.dart';
part 'configure_arduino_event.dart';
part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends Bloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  static const deviceBleName = 'ESP-32 WeatherStation';

  final FlushbarHelper _flushbarHelper;
  final DeviceConnector _deviceConnector;

  ConfigureArduinoBloc(
    this._flushbarHelper,
    this._deviceConnector,
  ) : super(const ConfigureArduinoState.nothing());

  @override
  Stream<ConfigureArduinoState> mapEventToState(
    ConfigureArduinoEvent event,
  ) async* {
    yield* event.map(
      onScreenStarted: _mapOnScreenStarted,
      onRetryClicked: _mapOnRetryClicked,
      onPermissionDialogPositiveClicked: _mapOnPermissionDialogPositiveClicked,
    );
  }

  @override
  Future<void> close() async {
    await _deviceConnector.close();
    return super.close();
  }

  Stream<ConfigureArduinoState> _mapOnScreenStarted(
    OnScreenStarted event,
  ) async* {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      yield const ConfigureArduinoState.renderError(
        message: Strings.connectToDevicePermissionError,
        loading: false,
      );
      yield* _showPermissionInfoDialog();
      return;
    }
    yield* _setupBleManager();
  }

  Stream<ConfigureArduinoState> _mapOnRetryClicked(
      OnRetryClicked event,) async* {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      yield* _showPermissionInfoDialog();
      return;
    }
    yield* _setupBleManager();
  }

  Stream<ConfigureArduinoState> _showPermissionInfoDialog() async* {
    yield const ConfigureArduinoState.showPermissionInfoDialog();
    yield const ConfigureArduinoState.nothing();
  }

  Stream<ConfigureArduinoState> _mapOnPermissionDialogPositiveClicked(
      OnPermissionDialogPositiveClicked event,) async* {
    final opened = await openAppSettings();
    if (!opened) {
      _flushbarHelper.showError(message: Strings.openAppSettingsError);
    }
  }

  Stream<ConfigureArduinoState> _setupBleManager() async* {
    yield const ConfigureArduinoState.connecting();
    yield await _deviceConnector
        .setupBleManager()
        .then((_) => const ConfigureArduinoState.renderWifiInputs())
        .catchError(
          (Object e) {
        PlainLocalizedString message;
        if (e is DeviceConnectionException) {
          message = e.map(
            permissionNotGranted: (_) => Strings.connectToDevicePermissionError,
            permissionPermanentlyDenied: (_) =>
            Strings.connectToDevicePermissionError,
            unknown: (_) => Strings.connectToDeviceUnknownError,
          );
        } else {
          message = Strings.connectToDeviceUnknownError;
        }

        _flushbarHelper.showError(message: message);
        return Future.value(
          ConfigureArduinoState.renderError(
            message: message,
            loading: false,
          ),
        );
      },
      test: (e) => e is DeviceConnectionException,
    );
  }
}
