part of 'hourly_weather_bloc.dart';

@freezed
class HourlyWeatherState with _$HourlyWeatherState {
  const factory HourlyWeatherState.initialLoading() = InitialLoading;

  const factory HourlyWeatherState.availableDaysFetched({
    required bool isLoading,
    required List<DateTime> availableDays,
    String? errorMessage,
  }) = AvailableDaysFetched;

  const factory HourlyWeatherState.hourlyWeatherFetched({
    required bool isLoading,
    required List<DateTime> availableDays,
    required List<Weather> hourlyWeather,
    String? errorMessage,
  }) = HourlyWeatherFetched;

  const factory HourlyWeatherState.initialError({
    required String message,
  }) = InitialError;
}
