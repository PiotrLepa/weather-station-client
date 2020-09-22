import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/domain/bloc/bloc_helper.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'current_weather_bloc.freezed.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

@injectable
class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  static const _weatherFetchDelayMinutes = 5;

  final WeatherRepository _weatherRepository;
  final FlushbarHelper _flushbarHelper;

  Weather _fetchedWeather;

  CurrentWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(const CurrentWeatherState.initialLoading());

  @override
  Stream<CurrentWeatherState> mapEventToState(
      CurrentWeatherEvent event) async* {
    yield* event.map(
      pageStarted: _mapPageStarted,
      refreshPressed: _mapRefreshPage,
      retryPressed: _mapRetryPressed,
    );
  }

  Stream<CurrentWeatherState> _mapPageStarted(
    PageStarted event,
  ) async* {
    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield const CurrentWeatherState.initialLoading();
        },
        success: (weather) async* {
          _fetchedWeather = weather;
          yield CurrentWeatherState.renderWeather(
            weather: weather,
            refreshLoading: false,
          );
        },
        error: (message) async* {
          await _flushbarHelper.showError(message: message);
          yield CurrentWeatherState.renderError(
            message: KeyString('fetchDataFailed'),
            loading: false,
          );
        },
      );
    }
  }

  Stream<CurrentWeatherState> _mapRefreshPage(
    RefreshPressed event,
  ) async* {
    if (!_shouldRefreshWeather()) {
      await _flushbarHelper.showSuccess(message: KeyString('dataUpToDate'));
      yield CurrentWeatherState.renderWeather(
        weather: _fetchedWeather,
        refreshLoading: false,
      );
      return;
    }

    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield CurrentWeatherState.renderWeather(
            weather: _fetchedWeather,
            refreshLoading: true,
          );
        },
        success: (weather) async* {
          _fetchedWeather = weather;
          await _flushbarHelper.showSuccess(message: KeyString('dataUpdated'));
          yield CurrentWeatherState.renderWeather(
            weather: weather,
            refreshLoading: false,
          );
        },
        error: (message) async* {
          await _flushbarHelper.showError(message: message);
          if (_fetchedWeather != null) {
            yield CurrentWeatherState.renderWeather(
              weather: _fetchedWeather,
              refreshLoading: false,
            );
          } else {
            yield CurrentWeatherState.renderError(
              message: KeyString('fetchDataFailed'),
              loading: false,
            );
          }
        },
      );
    }
  }

  bool _shouldRefreshWeather() =>
      _fetchedWeather == null ||
      (DateTime.now().difference(_fetchedWeather.date).inMinutes >=
          _weatherFetchDelayMinutes);

  Stream<CurrentWeatherState> _mapRetryPressed(
    RetryPressed event,
  ) async* {
    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          final errorState = state as RenderError;
          yield errorState.copyWith(loading: true);
        },
        success: (weather) async* {
          _fetchedWeather = weather;
          yield CurrentWeatherState.renderWeather(
            weather: weather,
            refreshLoading: false,
          );
        },
        error: (message) async* {
          await _flushbarHelper.showError(message: message);
          yield CurrentWeatherState.renderError(
            message: KeyString('fetchDataFailed'),
            loading: false,
          );
        },
      );
    }
  }
}
