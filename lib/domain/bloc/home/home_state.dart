part of 'home_bloc.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initialLoading() = InitialLoading;

  const factory HomeState.renderWeather(Weather weather) = RenderWeather;

  const factory HomeState.renderError(RKString message) = RenderError;
}
