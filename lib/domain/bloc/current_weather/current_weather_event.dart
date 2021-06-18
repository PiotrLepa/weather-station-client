part of 'current_weather_bloc.dart';

@freezed
class CurrentWeatherEvent with _$CurrentWeatherEvent implements BlocEvent {
  const factory CurrentWeatherEvent.pageStarted() = PageStarted;

  const factory CurrentWeatherEvent.refreshPressed() = RefreshPressed;

  const factory CurrentWeatherEvent.retryPressed() = RetryPressed;
}
