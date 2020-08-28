import 'package:weather_station/domain/entity/weather/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchCurrentWeather();
}
