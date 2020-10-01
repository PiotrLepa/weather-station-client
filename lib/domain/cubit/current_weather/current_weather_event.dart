part of 'current_weather_bloc.dart';

@freezed
abstract class CurrentWeatherEvent
    with _$CurrentWeatherEvent
    implements CubitEvent {
  const factory CurrentWeatherEvent.pageStarted() = PageStarted;

  const factory CurrentWeatherEvent.refreshPressed() = RefreshPressed;

  const factory CurrentWeatherEvent.retryPressed() = RetryPressed;
}