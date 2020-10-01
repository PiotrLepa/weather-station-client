part of 'hourly_weather_bloc.dart';

@freezed
abstract class HourlyWeatherState
    with _$HourlyWeatherState
    implements BlocState {
  const factory HourlyWeatherState.initial({
    @required bool selectDateLoading,
  }) = Initial;

  const factory HourlyWeatherState.renderCharts({
    @required KtList<Weather> weathers,
    @required bool changeDateLoading,
  }) = RenderCharts;
}
