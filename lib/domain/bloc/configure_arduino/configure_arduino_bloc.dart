import 'dart:async';

import 'package:async/async.dart' show StreamGroup;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connection_exception.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/device_connector.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/loading_images_provider.dart';
import 'package:weather_station/gen/assets.gen.dart';

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
  ) : super(ConfigureArduinoState.loading(getNextLoadingImage()));

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
    await _deviceConnector.close();
    return super.close();
  }

  Stream<ConfigureArduinoState> mapOnScreenStarted(
    OnScreenStarted event,
  ) async* {
    final imageStream = Stream<ConfigureArduinoState>.periodic(
      const Duration(seconds: 1),
          (_) => ConfigureArduinoState.loading(getNextLoadingImage()),
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
    return _deviceConnector
        .setupBleManager()
        .then((_) => const ConfigureArduinoState.renderWifiInputs())
        .catchError((Object e) {
      final message = (e as DeviceConnectionException).map(
        permissionNotGranted: (_) => Strings.connectToDeviceError,
        unknown: (_) => Strings.connectToDeviceError,
      );
      _flushbarHelper.showError(message: message);
      return Future.value(const ConfigureArduinoState.renderError());
    }, test: (e) => e is DeviceConnectionException);
  }
}
