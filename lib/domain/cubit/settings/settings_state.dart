part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState implements CubitState {
  const factory SettingsState.renderPage() = RenderPage;
}
