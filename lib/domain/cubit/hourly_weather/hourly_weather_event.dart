part of 'hourly_weather_cubit.dart';

@freezed
abstract class HourlyWeatherEvent
    with _$HourlyWeatherEvent
    implements CubitEvent {
  const factory HourlyWeatherEvent.loadPressed(DateTime day) = LoadPressed;

  const factory HourlyWeatherEvent.changeDatePressed(DateTime day) =
      ChangeDatePressed;
}
