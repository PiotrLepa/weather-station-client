part of 'configure_arduino_cubit.dart';

@freezed
abstract class ConfigureArduinoEvent
    with _$ConfigureArduinoEvent
    implements CubitEvent {
  const factory ConfigureArduinoEvent.onScreenStarted() = OnScreenStarted;

  const factory ConfigureArduinoEvent.onRetryClicked() = OnRetryClicked;

  const factory ConfigureArduinoEvent.onPermissionDialogPositiveClicked() =
      OnPermissionDialogPositiveClicked;
}
