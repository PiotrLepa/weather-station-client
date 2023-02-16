import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station_client/feature/home/pages/current/data/json/firebase_timestamp_json_converter.dart';

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
    @FirebaseTimestampJsonConverter() required Timestamp timestamp,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
