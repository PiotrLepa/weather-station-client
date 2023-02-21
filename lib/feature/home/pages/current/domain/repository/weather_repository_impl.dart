import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/converter/weather_converter.dart';
import 'package:weather_station_client/feature/home/pages/current/data/service/firestore_service.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/converter/available_days_converter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/model/available_days.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final FirestoreService _service;
  final WeatherConverter _weatherConverter;
  final AvailableDaysConverter _availableDaysConverter;

  WeatherRepositoryImpl(
    this._service,
    this._weatherConverter,
    this._availableDaysConverter,
  );

  @override
  Future<Weather> getLastWeather() =>
      _service.getLastWeather().then(_weatherConverter.toDomain);

  @override
  Future<AvailableDays> getAvailableDays() =>
      _service.getAvailableDays().then(_availableDaysConverter.toDomain);

  @override
  Future<List<Weather>> getWeathersForDay(DateTime day) => _service
      .getWeathersForDay(day)
      .then((weathers) => weathers.map(_weatherConverter.toDomain).toList());
}
