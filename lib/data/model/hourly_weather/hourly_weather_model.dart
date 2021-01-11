import 'package:freezed_annotation/freezed_annotation.dart';

part 'hourly_weather_model.freezed.dart';

part 'hourly_weather_model.g.dart';

@freezed
abstract class HourlyWeatherModel with _$HourlyWeatherModel {
  const factory HourlyWeatherModel({
    @required double temperature,
    @required double humidity,
    @required int pressure,
    @required int pm1,
    @required int pm25,
    @required int pm10,
    @required double windSpeedMax,
    @required double windSpeedAvg,
    @required double rainGauge,
    @required String dateTime,
  }) = _HourlyWeatherModel;

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherModelFromJson(json);
  static const fromJsonFactory = _$HourlyWeatherModelFromJson;
}
