part of 'settings_bloc.dart';

@freezed
class SettingsState with _$SettingsState implements BlocState {
  const factory SettingsState.nothing() = Nothing;

  const factory SettingsState.loading() = Loading;

  const factory SettingsState.renderItems({
    required bool pushEnabled,
  }) = RenderItems;

  const factory SettingsState.pushConfigureStationScreen() =
      PushConfigureStationScreen;

  const factory SettingsState.pushAboutAppScreen() = PushAboutAppScreen;
}
