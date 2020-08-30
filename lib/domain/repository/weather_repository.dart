import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchCurrentWeather();

  Future<KtList<Weather>> fetchHourlyWeather(DateTime day);
}