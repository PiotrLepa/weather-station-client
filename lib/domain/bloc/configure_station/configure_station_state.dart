part of 'configure_station_bloc.dart';

@freezed
class ConfigureStationState with _$ConfigureStationState implements BlocState {
  const factory ConfigureStationState.nothing() = Nothing;

  const factory ConfigureStationState.connecting() = Connecting;

  const factory ConfigureStationState.renderWifiList(KtList<Wifi> wifiList) =
      RenderWifiList;

  const factory ConfigureStationState.renderError({
    required PlainLocalizedString message,
    required bool loading,
  }) = RenderError;

  const factory ConfigureStationState.showWifiPasswordInputDialog(Wifi wifi) =
      ShowWifiPasswordInputDialog;

  const factory ConfigureStationState.showPermissionInfoDialog() =
      ShowPermissionInfoDialog;

  const factory ConfigureStationState.showConnectingToWifiDialog() =
      ShowConnectingToWifiDialog;

  const factory ConfigureStationState.pop() = Pop;
}
