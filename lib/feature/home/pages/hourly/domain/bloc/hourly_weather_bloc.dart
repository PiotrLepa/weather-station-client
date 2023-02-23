import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/usecase/get_hourly_weather_use_case.dart';

part 'hourly_weather_bloc.freezed.dart';
part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository _weatherRepository;
  final GetHourlyWeatherUseCase _getHourlyWeatherUseCase;

  HourlyWeatherBloc(
    this._weatherRepository,
    this._getHourlyWeatherUseCase,
  ) : super(const InitialLoading()) {
    on<ScreenStarted>(_onScreenStarted);
    on<RetryPressed>(_onRetryPressed);
    on<DateSelected>(_onDateSelected);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    await _weatherRepository
        .getAvailableDays()
        .then((availableDays) => emit(
              AvailableDaysFetched(
                isLoading: false,
                availableDays: availableDays.days,
              ),
            ))
        .catchError((e) => emit(InitialError(message: e.toString())));
  }

  Future<void> _onRetryPressed(
    RetryPressed event,
    Emitter<HourlyWeatherState> emit,
  ) async {
// TODO
  }

  Future<void> _onDateSelected(
    DateSelected event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    final previousState = state as AvailableDaysFetched;
    await _getHourlyWeatherUseCase
        .invoke(event.day)
        .then((hourlyWeather) => emit(HourlyWeatherFetched(
              isLoading: false,
              availableDays: previousState.availableDays,
              hourlyWeather: hourlyWeather,
            )))
        .catchError((e) => emit(InitialError(
            message:
                e.toString()))); // TODO show snackbar instead of error page
  }
}
