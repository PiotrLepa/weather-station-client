import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_helper.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'hourly_weather_bloc.freezed.dart';
part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  WeatherRepository _weatherRepository;
  FlushbarHelper _flushbarHelper;

  KtList<Weather> _fetchedWeathers;

  DateTime get _weatherDate => _fetchedWeathers[0].date;

  HourlyWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(HourlyWeatherState.initial(selectDateLoading: false));

  @override
  Stream<HourlyWeatherState> mapEventToState(HourlyWeatherEvent event) async* {
    yield* event.map(
      loadPressed: _mapLoadPressed,
      changeDatePressed: mapChangeDatePressed,
    );
  }

  Stream<HourlyWeatherState> _mapLoadPressed(
    LoadPressed event,
  ) async* {
    final request = callApi(_weatherRepository.fetchHourlyWeather(event.day));
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          yield HourlyWeatherState.initial(selectDateLoading: true);
        },
        success: (weathers) async* {
          _fetchedWeathers = weathers;
          yield HourlyWeatherState.renderCharts(
            weathers: weathers,
            changeDateLoading: false,
          );
        },
        error: (message) async* {
          _flushbarHelper.showError(message: message);
          yield HourlyWeatherState.initial(selectDateLoading: false);
        },
      );
    }
  }

  Stream<HourlyWeatherState> mapChangeDatePressed(
    ChangeDatePressed event,
  ) async* {
    if (event.day == _weatherDate) {
      return;
    }
    final request = callApi(_weatherRepository.fetchHourlyWeather(event.day));
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {
          final currentState = state as RenderCharts;
          yield currentState.copyWith(changeDateLoading: true);
        },
        success: (weathers) async* {
          _flushbarHelper.showSuccess(message: Strings.dataUpdated);
          _fetchedWeathers = weathers;
          yield HourlyWeatherState.renderCharts(
            weathers: weathers,
            changeDateLoading: false,
          );
        },
        error: (message) async* {
          _flushbarHelper.showError(message: message);
          yield HourlyWeatherState.renderCharts(
            weathers: _fetchedWeathers,
            changeDateLoading: false,
          );
        },
      );
    }
  }
}
