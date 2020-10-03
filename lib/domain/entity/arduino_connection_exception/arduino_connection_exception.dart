import 'package:freezed_annotation/freezed_annotation.dart';

part 'arduino_connection_exception.freezed.dart';

@freezed
abstract class ArduinoConnectionException
    with _$ArduinoConnectionException
    implements Exception {
  const factory ArduinoConnectionException.permissionNotGranted() =
      PermissionNotGranted;

  const factory ArduinoConnectionException.permissionPermanentlyDenied() =
      PermissionPermanentlyDenied;

  const factory ArduinoConnectionException.unknown() = Unknown;
}
