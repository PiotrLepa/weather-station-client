part of 'settings_bloc.dart';

@freezed
abstract class SettingsState with _$SettingsState implements BlocState {
  const factory SettingsState.renderPage() = RenderPage;
}
