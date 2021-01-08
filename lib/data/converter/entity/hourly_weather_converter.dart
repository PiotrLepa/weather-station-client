import 'package:injectable/injectable.dart';
import 'package:weather_station/data/model/hourly_weather/hourly_weather_model.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';

@lazySingleton
class HourlyWeatherConverter {
  HourlyWeather toEntity(HourlyWeatherModel model) => HourlyWeather(
        temperature: model.temperature,
        humidity: model.humidity,
        pressure: model.pressure,
        pm1: model.pm1,
        pm25: model.pm25,
        pm10: model.pm10,
        windSpeedMax: model.windSpeedMax,
        windSpeedAvg: model.windSpeedAvg,
        rainGauge: model.rainGauge,
        dateTime: DateTime.parse(model.dateTime),
      );
}
