part of 'configure_station_bloc.dart';

@freezed
abstract class ConfigureStationState
    with _$ConfigureStationState
    implements BlocState {
  const factory ConfigureStationState.nothing() = Nothing;

  const factory ConfigureStationState.connecting() = Connecting;

  const factory ConfigureStationState.renderWifiList(KtList<Wifi> wifiList) =
      RenderWifiList;

  const factory ConfigureStationState.renderWifiInputs() = RenderWifiInputs;

  const factory ConfigureStationState.renderError({
    @required PlainLocalizedString message,
    @required bool loading,
  }) = RenderError;

  const factory ConfigureStationState.showPermissionInfoDialog() =
  ShowPermissionInfoDialog;
}
