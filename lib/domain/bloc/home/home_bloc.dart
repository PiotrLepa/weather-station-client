import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/domain/bloc/bloc_helper.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  WeatherRepository _weatherRepository;

  HomeBloc(this._weatherRepository) : super(HomeState.initialLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is PageStarted) {
      yield* _mapPageStartedEvent(event);
    }
  }

  Stream<HomeState> _mapPageStartedEvent(
    PageStarted event,
  ) async* {
    final request = callApi(_weatherRepository.fetchCurrentWeather());
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield HomeState.initialLoading();
        },
        success: (response) async* {
          yield HomeState.renderWeather(response);
        },
        error: (errorMessage) async* {
          yield HomeState.renderError(errorMessage);
        },
      );
    }
  }
}
