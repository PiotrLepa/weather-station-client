part of 'hourly_weather_cubit.dart';

@freezed
abstract class HourlyWeatherState
    with _$HourlyWeatherState
    implements CubitState {
  const factory HourlyWeatherState.initial({
    @required bool selectDateLoading,
  }) = Initial;

  const factory HourlyWeatherState.renderCharts({
    @required KtList<Weather> weathers,
    @required bool changeDateLoading,
  }) = RenderCharts;
}
