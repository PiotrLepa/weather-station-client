part of 'hourly_weather_bloc.dart';

@freezed
abstract class HourlyWeatherEvent with _$HourlyWeatherEvent {
  const factory HourlyWeatherEvent.onLoadClicked(DateTime day) = OnLoadClicked;
}
