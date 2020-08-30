part of 'hourly_weather_bloc.dart';

@freezed
abstract class HourlyWeatherState with _$HourlyWeatherState {
  const factory HourlyWeatherState.initialLoading() = InitialLoading;

  const factory HourlyWeatherState.renderWeathers(KtList<Weather> weathers) =
      RenderWeathers;

  const factory HourlyWeatherState.renderError(RKString message) = RenderError;
}
