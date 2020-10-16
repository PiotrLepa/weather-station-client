part of 'about_app_bloc.dart';

@freezed
abstract class AboutAppState with _$AboutAppState implements BlocState {
  const factory AboutAppState.renderItems() = RenderItems;
}
