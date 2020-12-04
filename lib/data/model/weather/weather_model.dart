import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
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
    String address,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
  static const fromJsonFactory = _$WeatherModelFromJson;
}
