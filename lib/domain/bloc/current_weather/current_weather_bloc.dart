import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
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
  WeatherRepository _weatherRepository;

  CurrentWeatherBloc(this._weatherRepository)
      : super(CurrentWeatherState.initialLoading());

  @override
  Stream<CurrentWeatherState> mapEventToState(
      CurrentWeatherEvent event) async* {
    if (event is PageStarted) {
      yield* _mapPageStartedEvent(event);
    }
  }

  Stream<CurrentWeatherState> _mapPageStartedEvent(
    PageStarted event,
  ) async* {
    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield CurrentWeatherState.initialLoading();
        },
        success: (response) async* {
          yield CurrentWeatherState.renderWeather(response);
        },
        error: (errorMessage) async* {
          yield CurrentWeatherState.renderError(errorMessage);
        },
      );
    }
  }
}
