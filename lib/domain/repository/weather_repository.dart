import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/available_days/available_days.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchCurrentWeather();

  Future<AvailableDays> fetchAvailableDays();

  Future<KtList<HourlyWeather>> fetchHourlyWeather(DateTime day);
}
