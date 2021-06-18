part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent implements BlocEvent {
  const factory SettingsEvent.pageStarted() = PageStarted;

  const factory SettingsEvent.configureWifiClicked() = ConfigureWifiClicked;

  const factory SettingsEvent.aboutAppClicked() = AboutAppClicked;

  const factory SettingsEvent.pushNotificationsSwitchChanged({
    required bool isChecked,
  }) = PushNotificationsSwitchChanged;
}
