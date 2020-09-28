import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/domain/bloc/configure_arduino/util/configure_arduino_connecting_images.dart';
import 'package:weather_station/gen/assets.gen.dart';

part 'configure_arduino_bloc.freezed.dart';

part 'configure_arduino_event.dart';

part 'configure_arduino_state.dart';

@injectable
class ConfigureArduinoBloc
    extends Bloc<ConfigureArduinoEvent, ConfigureArduinoState> {
  Timer _imagesTimer;

  ConfigureArduinoBloc()
      : super(ConfigureArduinoState.loading(getNextImage())) {
    _imagesTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(const ConfigureArduinoEvent.updateConnectingImage());
    });
  }

  @override
  Stream<ConfigureArduinoState> mapEventToState(
    ConfigureArduinoEvent event,
  ) async* {
    yield* event.map(
      updateConnectingImage: _mapUpdateConnectingImage,
    );
  }

  @override
  Future<void> close() {
    _imagesTimer?.cancel();
    return super.close();
  }

  Stream<ConfigureArduinoState> _mapUpdateConnectingImage(
    UpdateConnectingImage event,
  ) async* {
    yield ConfigureArduinoState.loading(getNextImage());
  }
}
