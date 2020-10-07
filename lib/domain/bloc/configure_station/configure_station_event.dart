part of 'configure_station_bloc.dart';

@freezed
abstract class ConfigureStationEvent
    with _$ConfigureStationEvent
    implements BlocEvent {
  const factory ConfigureStationEvent.onScreenStarted() = OnScreenStarted;

  const factory ConfigureStationEvent.onRetryClicked() = OnRetryClicked;

  const factory ConfigureStationEvent.onPermissionDialogPositiveClicked() =
      OnPermissionDialogPositiveClicked;

  const factory ConfigureStationEvent.onWifiSelected(Wifi wifi) =
      OnWifiSelected;

  const factory ConfigureStationEvent.onPasswordInserted(
      WifiCredentials wifiCredentials) = OnPasswordInserted;
}
