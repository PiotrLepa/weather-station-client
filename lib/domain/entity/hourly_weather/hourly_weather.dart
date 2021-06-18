import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_weather.freezed.dart';

@freezed
class HourlyWeather with _$HourlyWeather {
  const factory HourlyWeather({
    required double temperature,
    required double humidity,
    required int pressure,
    required int pm1,
    required int pm25,
    required int pm10,
    required double windSpeedMax,
    required double windSpeedAvg,
    required double rainGauge,
    required DateTime dateTime,
  }) = _HourlyWeather;
}
