import 'dart:async';

import 'package:auto_localized/auto_localized.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/connect_to_wifi_result/connect_to_wifi_result.dart';
import 'package:weather_station/domain/entity/station_exception/station_exception.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';
import 'package:weather_station/domain/entity/wifi_encryption/wifi_encryption.dart';
import 'package:weather_station/domain/utils/station_configurator/station_configurator.dart';

part 'configure_station_bloc.freezed.dart';
part 'configure_station_event.dart';
part 'configure_station_state.dart';

@injectable
class ConfigureStationBloc
    extends CustomBloc<ConfigureStationEvent, ConfigureStationState> {
  final FlushbarHelper _flushbarHelper;
  final StationConfigurator _stationConfigurator;

  StreamSubscription<KtList<Wifi>> _availableWifiSubscription;
  StreamSubscription<ConnectToWifiResult> _connectToWifiResultSubscription;

  ConfigureStationBloc(
    this._flushbarHelper,
    this._stationConfigurator,
  ) : super(const Nothing());

  @override
  Future<void> onEvent(ConfigureStationEvent event) async {
    await event.map(
        onScreenStarted: _mapOnScreenStarted,
        onRetryClicked: _mapOnRetryClicked,
        onPermissionDialogPositiveClicked:
            _mapOnPermissionDialogPositiveClicked,
        onWifiSelected: _mapOnWifiSelected,
        onPasswordInserted: _mapOnPasswordInserted);
  }

  @override
  Future<void> close() async {
    await _availableWifiSubscription?.cancel();
    await _connectToWifiResultSubscription?.cancel();
    await _stationConfigurator.disconnectAndCancelOperations();
    await _stationConfigurator.close();
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
    _emitStationConfigurationStates();
  }

  Future<void> _mapOnRetryClicked(
    OnRetryClicked event,
  ) async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      await _showPermissionInfoDialog();
      return;
    }
    _emitStationConfigurationStates();
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
    if (event.wifi.encryption is Open) {
      final credentials = WifiCredentials(name: event.wifi.name);
      await _sendWifiCredentials(credentials);
      return;
    }
    emit(ShowWifiPasswordInputDialog(event.wifi));
    emit(const Nothing());
  }

  Future<void> _mapOnPasswordInserted(
    OnPasswordInserted event,
  ) async {
    emit(const ShowConnectingToWifiDialog());
    _observeConnectToWifiResult();
    await Future<void>.delayed(
        const Duration(seconds: 1)); // give ble time to start observing
    await _sendWifiCredentials(event.wifiCredentials);
  }

  Future<void> _sendWifiCredentials(WifiCredentials credentials) {
    return _stationConfigurator.sendWifiCredentials(credentials).catchError(
          (Object e) {
        final message = _translateStationException(e);
        _flushbarHelper.showError(message: message);
      },
    );
  }

  void _observeConnectToWifiResult() {
    if (_connectToWifiResultSubscription != null) {
      return;
    }

    _connectToWifiResultSubscription =
        _stationConfigurator.observeConnectToWifiResult().handleError(
      (Object error) async {
        await _connectToWifiResultSubscription?.cancel();
        _connectToWifiResultSubscription = null;
        _stationConfigurator.disconnectAndCancelOperations();

        appNavigator.pop();

        final message = _translateStationException(error);
        _flushbarHelper.showError(message: message);
      },
    ).listen(
      (result) {
        appNavigator.pop();
        result.map(
          connected: (_) {
            appNavigator.pop();
            _flushbarHelper.showSuccess(
              message: Strings.connectStationToWifiSuccess,
            );
          },
          error: (_) {
            _flushbarHelper.showError(
              message: Strings.connectStationToWifiError,
            );
          },
        );
      },
    );
  }

  void _emitStationConfigurationStates() {
    emit(const Connecting());

    if (_availableWifiSubscription != null) {
      return;
    }

    _availableWifiSubscription = _stationConfigurator
        .connect()
        .asStream()
        .asyncExpand((_) => _stationConfigurator.observeAvailableWifiList())
        .handleError(
          (Object error) async {
        await _availableWifiSubscription?.cancel();
        _availableWifiSubscription = null;
        _stationConfigurator.disconnectAndCancelOperations();

        final message = _translateStationException(error);
        _flushbarHelper.showError(message: message);
        emit(RenderError(
          message: message,
          loading: false,
        ));
      },
    ).listen((wifiList) => emit(RenderWifiList(wifiList)));
  }

  PlainLocalizedString _translateStationException(Object e) {
    if (e is StationException) {
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
