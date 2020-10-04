import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_exception.freezed.dart';

@freezed
abstract class StationException with _$StationException implements Exception {
  const factory StationException.permissionNotGranted() = PermissionNotGranted;

  const factory StationException.permissionPermanentlyDenied() =
      PermissionPermanentlyDenied;

  const factory StationException.unknown() = Unknown;
}
