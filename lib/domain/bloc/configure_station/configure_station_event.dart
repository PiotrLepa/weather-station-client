part of 'configure_station_bloc.dart';

@freezed
abstract class ConfigureStationEvent
    with _$ConfigureStationEvent
    implements BlocEvent {
  const factory ConfigureStationEvent.screenStarted() = ScreenStarted;

  const factory ConfigureStationEvent.retryClicked() = RetryClicked;

  const factory ConfigureStationEvent.permissionDialogPositiveClicked() =
      PermissionDialogPositiveClicked;

  const factory ConfigureStationEvent.wifiSelected(Wifi wifi) = WifiSelected;

  const factory ConfigureStationEvent.passwordInserted(
      WifiCredentials wifiCredentials) = PasswordInserted;
}
