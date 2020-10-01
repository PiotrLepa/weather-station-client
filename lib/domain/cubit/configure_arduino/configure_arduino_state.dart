part of 'configure_arduino_cubit.dart';

@freezed
abstract class ConfigureArduinoState
    with _$ConfigureArduinoState
    implements CubitState {
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
