import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station_client/feature/home/pages/current/data/json/firebase_timestamp_json_converter.dart';

part 'available_days_response.freezed.dart';
part 'available_days_response.g.dart';

@freezed
class AvailableDayResponse with _$AvailableDayResponse {
  const factory AvailableDayResponse({
    @FirebaseTimestampJsonConverter() required Timestamp day,
  }) = _AvailableDayResponse;

  factory AvailableDayResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableDayResponseFromJson(json);
}
