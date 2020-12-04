import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/data/network/network_error_handler.dart';
import 'package:weather_station/core/presentation/date_time/date_time_formatter.dart';
import 'package:weather_station/data/converter/entity/hourly_weather_entity_converter.dart';
import 'package:weather_station/data/converter/entity/weather_entity_converter.dart';
import 'package:weather_station/data/service/rest_service.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final RestService _service;
  final WeatherEntityConverter _weatherConverter;
  final HourlyWeatherEntityConverter _hourlyWeatherConverter;
  final DateTimeFormatter _dateFormatter;

  WeatherRepositoryImpl(
    this._service,
    this._weatherConverter,
    this._hourlyWeatherConverter,
    this._dateFormatter,
  );

  @override
  Future<Weather> fetchCurrentWeather() => _service
      .fetchCurrentWeather()
      .then(_weatherConverter.convert)
      .handleNetworkError();

  @override
  Future<KtList<HourlyWeather>> fetchHourlyWeather(DateTime day) =>
      _service
          .fetchHourlyWeather(
        _dateFormatter.format(day, DateTimeFormatter.networkDatePattern),
        DateTime
            .now()
            .timeZoneName,
      )
          .then((list) => list.map(_hourlyWeatherConverter.convert))
          .handleNetworkError();
}
