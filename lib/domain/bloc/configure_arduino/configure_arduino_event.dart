part of 'configure_arduino_bloc.dart';

@freezed
abstract class ConfigureArduinoEvent
    with _$ConfigureArduinoEvent
    implements BlocEvent {
  const factory ConfigureArduinoEvent.onScreenStarted() = OnScreenStarted;

  const factory ConfigureArduinoEvent.onRetryClicked() = OnRetryClicked;

  const factory ConfigureArduinoEvent.onPermissionDialogPositiveClicked() =
      OnPermissionDialogPositiveClicked;

  const factory ConfigureArduinoEvent.onWifiSelected(WifiCredentials wifi) =
      OnWifiSelected;
}
