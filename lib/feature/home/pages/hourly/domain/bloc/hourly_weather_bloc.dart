import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/use_case/get_available_days_use_case.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/use_case/get_hourly_weather_use_case.dart';

part 'hourly_weather_bloc.freezed.dart';
part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final GetAvailableDaysUseCase _getAvailableDaysUseCase;
  final GetHourlyWeatherUseCase _getHourlyWeatherUseCase;

  HourlyWeatherBloc(
    this._getAvailableDaysUseCase,
    this._getHourlyWeatherUseCase,
  ) : super(const InitialLoading()) {
    on<ScreenStarted>(_onScreenStarted);
    on<RetryPressed>(_onRetryPressed);
    on<DateSelected>(_onDateSelected);
    on<ChangeDatePressed>(_onChangeDatePressed);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    await _getAvailableDays(emit);
  }

  Future<void> _getAvailableDays(Emitter<HourlyWeatherState> emit) async {
    await _getAvailableDaysUseCase
        .invoke()
        .then((availableDays) => emit(
              AvailableDaysFetched(
                isLoading: false,
                availableDays: availableDays.days,
                isError: false,
              ),
            ))
        .catchError((e) => emit(const InitialError()));
  }

  Future<void> _onRetryPressed(
    RetryPressed event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    await _getAvailableDays(emit);
  }

  Future<void> _onDateSelected(
    DateSelected event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    final previousState = state as AvailableDaysFetched;
    emit(previousState.copyWith(
      isLoading: true,
      isError: false,
    ));
    await _getHourlyWeatherUseCase.invoke(event.day).then((hourlyWeather) {
      emit(HourlyWeatherFetched(
        isLoading: false,
        availableDays: previousState.availableDays,
        hourlyWeather: hourlyWeather,
        isError: false,
      ));
    }).catchError((e) {
      emit(previousState.copyWith(
        isLoading: false,
        isError: true,
      ));
    });
  }

  Future<void> _onChangeDatePressed(
    ChangeDatePressed event,
    Emitter<HourlyWeatherState> emit,
  ) async {
    final previousState = state as HourlyWeatherFetched;
    emit(previousState.copyWith(
      isLoading: true,
      isError: false,
    ));
    await _getHourlyWeatherUseCase.invoke(event.day).then((hourlyWeather) {
      emit(previousState.copyWith(
        isLoading: false,
        hourlyWeather: hourlyWeather,
      ));
    }).catchError((e) {
      emit(previousState.copyWith(
        isLoading: false,
        isError: true,
      ));
    });
  }
}
