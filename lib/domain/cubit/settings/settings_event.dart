part of 'settings_cubit.dart';

@freezed
abstract class SettingsEvent with _$SettingsEvent implements CubitEvent {
  const factory SettingsEvent.onConfigureWifiClicked() = OnConfigureWifiClicked;
}
