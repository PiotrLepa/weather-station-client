import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';

part 'available_days.freezed.dart';

@freezed
abstract class AvailableDays with _$AvailableDays {
  const factory AvailableDays({
    @required KtList<DateTime> days,
  }) = _AvailableDays;
}
