import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/core/presentation/date_time/date_time_parser.dart';
import 'package:weather_station/data/model/hourly_weather/hourly_weather_model.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';

@lazySingleton
class HourlyWeatherEntityConverter
    implements Converter<HourlyWeatherModel, HourlyWeather> {
  final DateTimeParser dateTimeParser;

  HourlyWeatherEntityConverter(
    this.dateTimeParser,
  );

  @override
  HourlyWeather convert(HourlyWeatherModel model) => HourlyWeather(
        temperature: model.temperature,
        humidity: model.humidity,
        pressure: model.pressure,
        pm1: model.pm1,
        pm25: model.pm25,
        pm10: model.pm10,
        windSpeedMax: model.windSpeedMax,
        windSpeedAvg: model.windSpeedAvg,
        rainGauge: model.rainGauge,
        dateTime: dateTimeParser.fromNetwork(model.dateTime),
      );
}
