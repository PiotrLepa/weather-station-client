import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/use_case/get_current_weather_use_case.dart';

part 'current_weather_bloc.freezed.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

@injectable
class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;

  CurrentWeatherBloc(
    this._getCurrentWeatherUseCase,
  ) : super(const Loading()) {
    on<ScreenStarted>(_onScreenStarted);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    await emit.onEach(
      _getCurrentWeatherUseCase.invoke(),
      onData: (weather) => emit(Success(weather: weather)),
      onError: (error, stackTrace) {
        log(
          "listen to last weather failed",
          error: error,
          stackTrace: stackTrace,
        );
        emit(const Error());
      },
    );
  }
}
