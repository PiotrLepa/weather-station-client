part of 'settings_bloc.dart';

@freezed
abstract class SettingsEvent with _$SettingsEvent implements BlocEvent {
  const factory SettingsEvent.onConfigureWifiClicked() = OnConfigureWifiClicked;

  const factory SettingsEvent.onAboutAppClicked() = OnAboutAppClicked;
}
