import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/data/network/network_error_handler.dart';
import 'package:weather_station/data/converter/entity/weather_entity_converter.dart';
import 'package:weather_station/data/service/rest_service.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/domain/repository/weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final RestService _service;
  final WeatherConverter _weatherConverter;

  WeatherRepositoryImpl(
    this._service,
    this._weatherConverter,
  );

  @override
  Future<Weather> fetchCurrentWeather() => _service
      .fetchCurrentWeather()
      .then(_weatherConverter.convert)
      .handleNetworkError();

  @override
  Future<KtList<Weather>> fetchHourlyWeather(DateTime day) => _service
      .fetchHourlyWeather(DateFormat('yyyy-MM-dd').format(day))
      .then((list) => list.map(_weatherConverter.convert))
      .handleNetworkError();
}