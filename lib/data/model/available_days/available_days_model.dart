import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_days_model.freezed.dart';

part 'available_days_model.g.dart';

@freezed
abstract class AvailableDaysModel with _$AvailableDaysModel {
  const factory AvailableDaysModel({
    @required List<DateTime> dates,
  }) = _AvailableDaysModel;

  factory AvailableDaysModel.fromJson(Map<String, dynamic> json) =>
      _$AvailableDaysModelFromJson(json);
  static const fromJsonFactory = _$AvailableDaysModelFromJson;
}
