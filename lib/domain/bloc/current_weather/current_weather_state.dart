part of 'current_weather_bloc.dart';

@freezed
abstract class CurrentWeatherState with _$CurrentWeatherState {
  const factory CurrentWeatherState.initialLoading() = InitialLoading;

  const factory CurrentWeatherState.nothing() = Nothing;

  const factory CurrentWeatherState.renderWeather({
    @required Weather weather,
    @required bool refreshLoading,
  }) = RenderWeather;

  const factory CurrentWeatherState.renderError({
    @required RKString message,
    @required bool loading,
  }) = RenderError;
}
