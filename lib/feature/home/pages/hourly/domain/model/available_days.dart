import 'package:freezed_annotation/freezed_annotation.dart';

part 'available_days.freezed.dart';

@freezed
class AvailableDays with _$AvailableDays {
  const factory AvailableDays({
    required List<DateTime> days,
  }) = _AvailableDays;
}
