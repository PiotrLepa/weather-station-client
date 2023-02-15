part of 'hourly_weather_bloc.dart';

@freezed
class HourlyWeatherEvent with _$HourlyWeatherEvent {
  const factory HourlyWeatherEvent.screenStarted() = ScreenStarted;

  const factory HourlyWeatherEvent.retryPressed() = RetryPressed;

  const factory HourlyWeatherEvent.dateSelected(DateTime day) = DateSelected;

  const factory HourlyWeatherEvent.changeDatePressed(DateTime day) =
      ChangeDatePressed;
}
