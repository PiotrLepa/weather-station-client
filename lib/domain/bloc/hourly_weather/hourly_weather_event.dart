part of 'hourly_weather_bloc.dart';

@freezed
class HourlyWeatherEvent with _$HourlyWeatherEvent implements BlocEvent {
  const factory HourlyWeatherEvent.screenStarted() = ScreenStarted;

  const factory HourlyWeatherEvent.retryPressed() = RetryPressed;

  const factory HourlyWeatherEvent.loadPressed(DateTime day) = LoadPressed;

  const factory HourlyWeatherEvent.changeDatePressed(DateTime day) =
      ChangeDatePressed;
}
