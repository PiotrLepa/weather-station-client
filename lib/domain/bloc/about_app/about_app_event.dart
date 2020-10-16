part of 'about_app_bloc.dart';

@freezed
abstract class AboutAppEvent with _$AboutAppEvent implements BlocEvent {
  const factory AboutAppEvent.onIconsClicked() = OnIconsClicked;

  const factory AboutAppEvent.onPackagesClicked() = OnPackagesClicked;
}
