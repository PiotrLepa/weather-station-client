library weather_model;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    @required double temperature,
    @required double humidity,
    @required double pressure,
    @required double pm1,
    @required double pm25,
    @required double pm10,
    @required double windSpeedMax,
    @required double windSpeedAvg,
    @required double rainGauge,
    @required String location,
    @required String date,
  }) = _WeatherModel;
}
