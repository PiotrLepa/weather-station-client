import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/model/available_days.dart';

abstract class WeatherRepository {
  Future<Weather> getLastWeather();

  Future<AvailableDays> getAvailableDays();

  Future<List<Weather>> getWeathersForDay(DateTime day);
}
