part of 'about_app_bloc.dart';

@freezed
class AboutAppEvent with _$AboutAppEvent implements BlocEvent {
  const factory AboutAppEvent.iconsClicked() = IconsClicked;

  const factory AboutAppEvent.packagesClicked() = PackagesClicked;
}
