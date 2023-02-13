import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';

part 'current_weather_bloc.freezed.dart';
part 'current_weather_event.dart';
part 'current_weather_state.dart';

@injectable
class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository _weatherRepository;

  CurrentWeatherBloc(
    this._weatherRepository,
  ) : super(const Loading()) {
    on<ScreenStarted>(_onScreenStarted);
  }

  Future<void> _onScreenStarted(
    ScreenStarted event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    await _weatherRepository
        .getLastWeather()
        .then((weather) => emit(Success(weather: weather)))
        .catchError((e) => emit(Error(message: e.toString())));
  }
}
