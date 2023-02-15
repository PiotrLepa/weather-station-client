part of 'hourly_weather_bloc.dart';

@freezed
class HourlyWeatherState with _$HourlyWeatherState {
  const factory HourlyWeatherState.loading() = Loading;

  const factory HourlyWeatherState.success({
    required bool isLoading,
    required List<DateTime> availableDays,
  }) = Success;

  const factory HourlyWeatherState.error({
    required String message,
  }) = Error;
}
