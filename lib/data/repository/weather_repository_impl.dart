import 'dart:async';

import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/data/network/error_handler/api_error_handler.dart';
import 'package:weather_station/core/presentation/date_time/date_time_formatter.dart';
import 'package:weather_station/data/converter/entity/available_days_converter.dart';
import 'package:weather_station/data/converter/entity/hourly_weather_converter.dart';
import 'package:weather_station/data/converter/entity/weather_converter.dart';
import 'package:weather_station/data/service/rest_service.dart';
import 'package:weather_station/domain/entity/available_days/available_days.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final RestService _service;
  final WeatherConverter _weatherConverter;
  final AvailableDaysConverter _availableDaysConverter;
  final HourlyWeatherConverter _hourlyWeatherConverter;
  final DateTimeFormatter _dateFormatter;

  WeatherRepositoryImpl(
    this._service,
    this._weatherConverter,
    this._availableDaysConverter,
    this._hourlyWeatherConverter,
    this._dateFormatter,
  );

  @override
  Future<Weather> fetchCurrentWeather() => _service
      .fetchCurrentWeather()
      .then(_weatherConverter.toEntity)
      .handleApiError();

  @override
  Future<AvailableDays> fetchAvailableDays() => _service
      .fetchAvailableDays()
      .then(_availableDaysConverter.toEntity)
      .handleApiError();

  @override
  Future<KtList<HourlyWeather>> fetchHourlyWeather(DateTime day) async =>
      _service
          .fetchHourlyWeather(
            _dateFormatter.format(day, DateTimeFormatter.networkDatePattern),
            await FlutterNativeTimezone.getLocalTimezone(),
          )
          .then((list) => list.map(_hourlyWeatherConverter.toEntity))
          .handleApiError();
}
