import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';

@injectable
class GetCurrentWeatherUseCase {
  final WeatherRepository _repository;

  GetCurrentWeatherUseCase(this._repository);

  Stream<Weather> invoke() => _repository.getLastWeather();
}
