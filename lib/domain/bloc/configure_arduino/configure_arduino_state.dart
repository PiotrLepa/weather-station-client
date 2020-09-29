part of 'configure_arduino_bloc.dart';

@freezed
abstract class ConfigureArduinoState with _$ConfigureArduinoState {
  const factory ConfigureArduinoState.nothing() = Nothing;

  const factory ConfigureArduinoState.connecting() = Connecting;

  const factory ConfigureArduinoState.renderWifiInputs() = RenderWifiInputs;

  const factory ConfigureArduinoState.renderError({
    @required PlainLocalizedString message,
    @required bool loading,
  }) = RenderError;

  const factory ConfigureArduinoState.showPermissionInfoDialog() =
      ShowPermissionInfoDialog;
}
