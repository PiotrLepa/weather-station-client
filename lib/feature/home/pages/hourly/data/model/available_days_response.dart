import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_days_response.freezed.dart';
part 'available_days_response.g.dart';

@freezed
class AvailableDaysResponse with _$AvailableDaysResponse {
  const factory AvailableDaysResponse({
    required List<DateTime> days,
  }) = _AvailableDaysResponse;

  factory AvailableDaysResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableDaysResponseFromJson(json);
  static const fromJsonFactory = _$AvailableDaysResponseFromJson;
}
