import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/converter/weather_converter.dart';
import 'package:weather_station_client/feature/home/pages/current/data/service/firestore_service.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';

@LazySingleton(as: WeatherRepository)
class WeatherRepositoryImpl extends WeatherRepository {
  final FirestoreService _service;
  final WeatherConverter _weatherConverter;

  WeatherRepositoryImpl(
    this._service,
    this._weatherConverter,
  );

  @override
  Future<Weather> getLastWeather() =>
      _service.getLastWeather().then(_weatherConverter.toDomain);
}
