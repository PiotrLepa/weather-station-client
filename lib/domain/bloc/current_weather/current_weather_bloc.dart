import 'package:auto_localized/auto_localized.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/domain/call/call_wrapper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'current_weather_bloc.freezed.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

@injectable
class CurrentWeatherBloc
    extends CustomBloc<CurrentWeatherEvent, CurrentWeatherState> {
  static const weatherFetchDelay = Duration(minutes: 5);

  final WeatherRepository _weatherRepository;
  final FlushbarHelper _flushbarHelper;

  Weather _fetchedWeather;

  CurrentWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(const InitialLoading());

  @override
  Future<void> onEvent(CurrentWeatherEvent event) async {
    await event.map(
      pageStarted: _mapPageStarted,
      refreshPressed: _mapRefreshPage,
      retryPressed: _mapRetryPressed,
    );
  }

  Future<void> _mapPageStarted(
    PageStarted event,
  ) async {
    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () => emit(const InitialLoading()),
      onSuccess: (result) {
        _fetchedWeather = result;
        emit(RenderWeather(
          weather: result,
          refreshLoading: false,
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

  Future<void> _mapRefreshPage(
    RefreshPressed event,
  ) async {
    if (!_shouldRefreshWeather()) {
      _flushbarHelper.showSuccess(message: Strings.dataUpToDate);
      return;
    }

    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () {
        emit(RenderWeather(
          weather: _fetchedWeather,
          refreshLoading: true,
        ));
      },
      onSuccess: (weather) {
        _fetchedWeather = weather;
        _flushbarHelper.showSuccess(message: Strings.dataUpdated);
        emit(RenderWeather(
          weather: weather,
          refreshLoading: false,
        ));
      },
      onError: (_, message) {
        _flushbarHelper.showError(message: message);
        emit(RenderWeather(
          weather: _fetchedWeather,
          refreshLoading: false,
        ));
      },
    );
  }

  bool _shouldRefreshWeather() =>
      _fetchedWeather == null ||
      (DateTime.now().difference(_fetchedWeather.dateTime) >=
          weatherFetchDelay);

  Future<void> _mapRetryPressed(
    RetryPressed event,
  ) async {
    await callWrapper<Weather>(
      call: _weatherRepository.fetchCurrentWeather(),
      onProgress: () {
        final errorState = state as RenderError;
        emit(errorState.copyWith(loading: true));
      },
      onSuccess: (weather) {
        _fetchedWeather = weather;
        emit(RenderWeather(
          weather: weather,
          refreshLoading: false,
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
}
