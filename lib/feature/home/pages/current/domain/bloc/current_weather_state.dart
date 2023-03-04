part of 'current_weather_bloc.dart';

@freezed
class CurrentWeatherState with _$CurrentWeatherState {
  const factory CurrentWeatherState.loading() = Loading;

  const factory CurrentWeatherState.success({required Weather weather}) =
      Success;

  const factory CurrentWeatherState.error() = Error;
}
