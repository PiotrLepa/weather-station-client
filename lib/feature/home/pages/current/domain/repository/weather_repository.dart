import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getLastWeather();
}
