part of 'hourly_weather_bloc.dart';

@freezed
class HourlyWeatherState with _$HourlyWeatherState implements BlocState {
  const factory HourlyWeatherState.initialLoading() = InitialLoading;

  const factory HourlyWeatherState.renderSelectDate({
    required bool selectDateLoading,
    required KtList<DateTime> availableDays,
  }) = RenderSelectDate;

  const factory HourlyWeatherState.renderError({
    required PlainLocalizedString message,
    required bool loading,
  }) = RenderError;

  const factory HourlyWeatherState.renderCharts({
    required KtList<HourlyWeather> weathers,
    required KtList<DateTime> availableDays,
    required bool changeDateLoading,
  }) = RenderCharts;
}
