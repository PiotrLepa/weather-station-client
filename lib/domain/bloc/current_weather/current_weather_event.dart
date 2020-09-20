part of 'current_weather_bloc.dart';

@freezed
abstract class CurrentWeatherEvent with _$CurrentWeatherEvent {
  const factory CurrentWeatherEvent.pageStarted() = PageStarted;

  const factory CurrentWeatherEvent.refreshPressed() = RefreshPressed;
}
