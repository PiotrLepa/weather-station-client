part of 'current_weather_bloc.dart';

@freezed
abstract class CurrentWeatherState with _$CurrentWeatherState {
  const factory CurrentWeatherState.initialLoading() = InitialLoading;

  const factory CurrentWeatherState.renderWeather(Weather weather) =
      RenderWeather;

  const factory CurrentWeatherState.renderError(RKString message) = RenderError;
}
