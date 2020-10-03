import 'dart:async';

import 'package:auto_localized/auto_localized.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/utils/arduino_configurator/arduino_configurator.dart';
import 'package:weather_station/domain/utils/arduino_configurator/exception/device_connection_exception.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi/wifi.dart';
import 'package:weather_station/domain/utils/arduino_configurator/model/wifi_credentials/wifi_credentials.dart';

part 'configure_arduino_bloc.freezed.dart';
part 'configure_arduino_event.dart';
part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends CustomBloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  final FlushbarHelper _flushbarHelper;
  final ArduinoConfigurator _arduinoConfigurator;

  StreamSubscription<KtList<Wifi>> _availableWifiSubscription;

  ConfigureArduinoBloc(
    this._flushbarHelper,
    this._arduinoConfigurator,
  ) : super(const Nothing());

  @override
  Future<void> onEvent(ConfigureArduinoEvent event) async {
    await event.map(
      onScreenStarted: _mapOnScreenStarted,
      onRetryClicked: _mapOnRetryClicked,
      onPermissionDialogPositiveClicked: _mapOnPermissionDialogPositiveClicked,
      onWifiSelected: _mapOnWifiSelected,
    );
  }

  @override
  Future<void> close() async {
    await _availableWifiSubscription?.cancel();
    await _arduinoConfigurator.close();
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
    _emitArduinoConfiguratorStates();
  }

  Future<void> _mapOnRetryClicked(
    OnRetryClicked event,
  ) async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      await _showPermissionInfoDialog();
      return;
    }
    _emitArduinoConfiguratorStates();
  }

  Future<void> _showPermissionInfoDialog() async {
    emit(const ShowPermissionInfoDialog());
    emit(const Nothing());
  }

  Future<void> _mapOnPermissionDialogPositiveClicked(
    OnPermissionDialogPositiveClicked event,
  ) async {
    final opened = await openAppSettings();
    if (!opened) {
      _flushbarHelper.showError(message: Strings.openAppSettingsError);
    }
  }

  Future<void> _mapOnWifiSelected(
    OnWifiSelected event,
  ) async {
    await _arduinoConfigurator.sendWifiCredentials(event.wifi).catchError(
      (Object e) {
        final message = _translateArduinoException(e);
        _flushbarHelper.showError(message: message);
      },
    );
  }

  void _emitArduinoConfiguratorStates() {
    emit(const Connecting());

    _availableWifiSubscription = _arduinoConfigurator
        .connect()
        .asStream()
        .asyncExpand((_) => _arduinoConfigurator.observeAvailableWifiList())
        .handleError(_handleArduinoErrors)
        .listen((wifiList) => emit(RenderWifiList(wifiList)));
  }

  void _handleArduinoErrors(Object error) {
    _availableWifiSubscription?.cancel();
    _availableWifiSubscription = null;
    _arduinoConfigurator.disconnectAndCancelOperations();

    final message = _translateArduinoException(error);
    _flushbarHelper.showError(message: message);
    emit(RenderError(
      message: message,
      loading: false,
    ));
  }

  PlainLocalizedString _translateArduinoException(Object e) {
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
