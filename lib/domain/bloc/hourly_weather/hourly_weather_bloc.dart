import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/domain/bloc/bloc_helper.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

part 'hourly_weather_bloc.freezed.dart';
part 'hourly_weather_event.dart';
part 'hourly_weather_state.dart';

@injectable
class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  WeatherRepository _weatherRepository;
  FlushbarHelper _flushbarHelper;

  DateTime weatherDate;

  HourlyWeatherBloc(
    this._weatherRepository,
    this._flushbarHelper,
  ) : super(HourlyWeatherState.initial());

  @override
  Stream<HourlyWeatherState> mapEventToState(HourlyWeatherEvent event) async* {
    if (event is OnLoadClicked) {
      yield* _mapOnLoadClicked(event);
    }
  }

  Stream<HourlyWeatherState> _mapOnLoadClicked(
    OnLoadClicked event,
  ) async* {
    if (weatherDate == event.day) {
      return;
    }
    final request = callApi(_weatherRepository.fetchHourlyWeather(event.day));
    await for (final requestState in request) {
      yield* requestState.when(
        progress: () async* {},
        success: (weathers) async* {
          if (weatherDate != null) {
            _flushbarHelper.showSuccess(message: RawString('Zaktualizowano'));
          }
          weatherDate = weathers[0].date;
          yield HourlyWeatherState.renderCharts(weathers);
        },
        error: (message) async* {
          _flushbarHelper.showError(message: message);
          yield HourlyWeatherState.renderError(
            RawString('Nie udało się pobrać danych'),
          );
        },
      );
    }
  }
}
