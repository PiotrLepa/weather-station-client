import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/model/weather/weather_model.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';

@lazySingleton
class WeatherConverter implements Converter<WeatherModel, Weather> {
  @override
  Weather convert(WeatherModel model) => Weather(
        temperature: model.temperature,
        humidity: model.humidity,
        pressure: model.pressure,
        pm1: model.pm1,
        pm25: model.pm25,
        pm10: model.pm10,
        windSpeedMax: model.windSpeedMax,
        windSpeedAvg: model.windSpeedAvg,
        rainGauge: model.rainGauge,
        location: model.location ?? "Tarnów",
        // TODO
        date: DateTime.parse(model.date),
      );
}