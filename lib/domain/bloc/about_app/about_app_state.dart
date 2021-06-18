part of 'about_app_bloc.dart';

@freezed
class AboutAppState with _$AboutAppState implements BlocState {
  const factory AboutAppState.nothing() = Nothing;

  const factory AboutAppState.renderItems() = RenderItems;

  const factory AboutAppState.pushLicenseListScreen({
    required PlainLocalizedString title,
    required KtList<License> licenses,
  }) = PushLicenseListScreen;
}
