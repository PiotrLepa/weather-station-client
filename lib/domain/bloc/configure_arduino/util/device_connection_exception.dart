import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_connection_exception.freezed.dart';

@freezed
abstract class DeviceConnectionException
    with _$DeviceConnectionException
    implements Exception {
  const factory DeviceConnectionException.permissionNotGranted() =
      PermissionNotGranted;

  const factory DeviceConnectionException.unknown() = Unknown;
}
