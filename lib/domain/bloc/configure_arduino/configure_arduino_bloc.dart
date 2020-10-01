import 'dart:async';

import 'package:auto_localized/auto_localized.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connection_exception.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connector.dart';

part 'configure_arduino_bloc.freezed.dart';
part 'configure_arduino_event.dart';
part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends CustomBloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  static const deviceBleName = 'ESP-32 WeatherStation';

  final FlushbarHelper _flushbarHelper;
  final DeviceConnector _deviceConnector;

  ConfigureArduinoBloc(
    this._flushbarHelper,
    this._deviceConnector,
  ) : super(const Nothing());

  @override
  Future<void> onEvent(ConfigureArduinoEvent event) async {
    await event.map(
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

  Future<void> _mapOnScreenStarted(
    OnScreenStarted event,
  ) async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      emit(const RenderError(
        message: Strings.connectToDevicePermissionError,
        loading: false,
      ));
      await _showPermissionInfoDialog();
      return;
    }
    await _emitSetupBleState();
  }

  Future<void> _mapOnRetryClicked(
    OnRetryClicked event,
  ) async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      await _showPermissionInfoDialog();
      return;
    }
    await _emitSetupBleState();
  }

  Future<void> _showPermissionInfoDialog() async {
    emit(const ShowPermissionInfoDialog());
    emit(const Nothing());
  }

  Future<void> _mapOnPermissionDialogPositiveClicked(
      OnPermissionDialogPositiveClicked event,) async {
    final opened = await openAppSettings();
    if (!opened) {
      _flushbarHelper.showError(message: Strings.openAppSettingsError);
    }
  }

  Future<void> _emitSetupBleState() async {
    emit(const Connecting());

    final newState = await _deviceConnector
        .setupBleManager()
        .then<ConfigureArduinoState>((_) => const RenderWifiInputs())
        .catchError(
          (Object e) {
        final message = _getSetupBleErrorMessage(e);
        _flushbarHelper.showError(message: message);
        return Future<ConfigureArduinoState>.value(
          RenderError(
            message: message,
            loading: false,
          ),
        );
      },
    );

    emit(newState);
  }

  PlainLocalizedString _getSetupBleErrorMessage(Object e) {
    if (e is DeviceConnectionException) {
      return e.map(
        permissionNotGranted: (_) => Strings.connectToDevicePermissionError,
        permissionPermanentlyDenied: (_) =>
        Strings.connectToDevicePermissionError,
        unknown: (_) => Strings.connectToDeviceUnknownError,
      );
    } else {
      return Strings.connectToDeviceUnknownError;
    }
  }
}
