part of 'hourly_weather_bloc.dart';

@freezed
abstract class HourlyWeatherEvent with _$HourlyWeatherEvent {
  const factory HourlyWeatherEvent.loadPressed(DateTime day) = LoadPressed;

  const factory HourlyWeatherEvent.changeDatePressed(DateTime day) =
      ChangeDatePressed;
}
