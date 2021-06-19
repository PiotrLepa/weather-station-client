part of 'current_weather_bloc.dart';

@freezed
class CurrentWeatherState with _$CurrentWeatherState implements BlocState {
  const factory CurrentWeatherState.initialLoading() = InitialLoading;

  const factory CurrentWeatherState.renderWeather({
    required Weather weather,
    required bool refreshLoading,
  }) = RenderWeather;

  const factory CurrentWeatherState.renderError({
    required PlainLocalizedString message,
    required bool loading,
  }) = RenderError;
}
