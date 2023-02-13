import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    required double temperature,
    required double humidity,
    required int pressure,
    required int pm1,
    required int pm25,
    required int pm10,
    required double windSpeedMax,
    required double windSpeedAvg,
    required double precipitation,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
