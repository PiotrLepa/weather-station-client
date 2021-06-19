import 'package:auto_localized/auto_localized.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/domain/call/call_wrapper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/available_days/available_days.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'hourly_weather_bloc.freezed.dart';
part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherBloc
    extends CustomBloc<HourlyWeatherEvent, HourlyWeatherState> {
  final WeatherRepository _weatherRepository;
  final FlushbarHelper _flushbarHelper;

  late KtList<HourlyWeather> _fetchedWeathers;
  late KtList<DateTime> _availableDays;

  DateTime get _weatherDate => _fetchedWeathers[0].dateTime;

  HourlyWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(const InitialLoading());

  @override
  Future<void> onEvent(HourlyWeatherEvent event) async {
    await event.map(
      screenStarted: _mapScreenStarted,
      retryPressed: _mapRetryPressed,
      loadPressed: _mapLoadPressed,
      changeDatePressed: mapChangeDatePressed,
    );
  }

  Future<void> _mapScreenStarted(
    ScreenStarted event,
  ) async {
    await wrapCall<AvailableDays>(
      call: _weatherRepository.fetchAvailableDays(),
      onProgress: () {
        emit(const InitialLoading());
      },
      onSuccess: (availableDays) {
        _availableDays = availableDays.days;
        emit(RenderSelectDate(
          selectDateLoading: false,
          availableDays: _availableDays,
        ));
      },
      onError: (_, message) {
        emit(const RenderError(
          message: Strings.fetchDataFailed,
          loading: false,
        ));
      },
    );
  }

  Future<void> _mapRetryPressed(
    RetryPressed event,
  ) async {
    await wrapCall<AvailableDays>(
      call: _weatherRepository.fetchAvailableDays(),
      onProgress: () {
        final errorState = state as RenderError;
        emit(errorState.copyWith(loading: true));
      },
      onSuccess: (availableDays) {
        _availableDays = availableDays.days;
        emit(RenderSelectDate(
          selectDateLoading: false,
          availableDays: _availableDays,
        ));
      },
      onError: (_, message) {
        _flushbarHelper.showError(message: message);
        emit(const RenderError(
          message: Strings.fetchDataFailed,
          loading: false,
        ));
      },
    );
  }

  Future<void> _mapLoadPressed(
    LoadPressed event,
  ) async {
    await wrapCall<KtList<HourlyWeather>>(
      call: _weatherRepository.fetchHourlyWeather(event.day),
      onProgress: () {
        emit(RenderSelectDate(
          selectDateLoading: true,
          availableDays: _availableDays,
        ));
      },
      onSuccess: (weathers) {
        _fetchedWeathers = weathers;
        emit(RenderCharts(
          weathers: weathers,
          changeDateLoading: false,
          availableDays: _availableDays,
        ));
      },
      onError: (_, message) {
        _flushbarHelper.showError(message: message);
        emit(RenderSelectDate(
          selectDateLoading: false,
          availableDays: _availableDays,
        ));
      },
    );
  }

  Future<void> mapChangeDatePressed(
    ChangeDatePressed event,
  ) async {
    if (event.day == _weatherDate) {
      return;
    }

    await wrapCall<KtList<HourlyWeather>>(
      call: _weatherRepository.fetchHourlyWeather(event.day),
      onProgress: () {
        final currentState = state as RenderCharts;
        emit(currentState.copyWith(changeDateLoading: true));
      },
      onSuccess: (weathers) {
        _fetchedWeathers = weathers;
        _flushbarHelper.showSuccess(message: Strings.dataUpdated);
        _fetchedWeathers = weathers;
        emit(RenderCharts(
          weathers: weathers,
          changeDateLoading: false,
          availableDays: _availableDays,
        ));
      },
      onError: (_, message) {
        _flushbarHelper.showError(message: message);
        emit(RenderCharts(
          weathers: _fetchedWeathers,
          changeDateLoading: false,
          availableDays: _availableDays,
        ));
      },
    );
  }
}
