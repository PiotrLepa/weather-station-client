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

  WeatherRepository _weatherRepository;
  FlushbarHelper _flushbarHelper;

  Weather _fetchedWeather;

  CurrentWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(CurrentWeatherState.initialLoading());

  @override
  Stream<CurrentWeatherState> mapEventToState(
      CurrentWeatherEvent event) async* {
    yield* event.map(
      pageStarted: _mapPageStarted,
      refreshPressed: _mapRefreshPage,
    );
  }

  Stream<CurrentWeatherState> _mapPageStarted(PageStarted event,) async* {
    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield CurrentWeatherState.initialLoading();
        },
        success: (response) async* {
          _fetchedWeather = response;
          yield CurrentWeatherState.renderWeather(response);
        },
        error: (errorMessage) async* {
          yield CurrentWeatherState.renderError(errorMessage);
        },
      );
    }
  }

  Stream<CurrentWeatherState> _mapRefreshPage(RefreshPressed event,) async* {
    yield CurrentWeatherState.doNothing();

    if (!_shouldRefreshWeather()) {
      _flushbarHelper.showSuccess(message: RawString('Dane są aktualne'));
      yield CurrentWeatherState.renderWeather(_fetchedWeather);
    } else {
      final request = callApi(_weatherRepository.fetchCurrentWeather());
      await for (final requestState in request) {
        yield* requestState.when(
          progress: () async* {},
          success: (response) async* {
            _fetchedWeather = response;
            _flushbarHelper.showSuccess(message: RawString('Zaktualizowano'));
            yield CurrentWeatherState.renderWeather(response);
          },
          error: (errorMessage) async* {
            yield CurrentWeatherState.renderError(errorMessage);
          },
        );
      }
    }
  }

  bool _shouldRefreshWeather() =>
      DateTime
          .now()
          .difference(_fetchedWeather.date)
          .inMinutes >=
          _weatherFetchDelayMinutes;
}
