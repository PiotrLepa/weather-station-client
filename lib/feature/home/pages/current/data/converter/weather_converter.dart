import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/model/weather_response.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';

@injectable
class WeatherConverter {
  Weather toDomain(WeatherResponse response) => Weather(
        temperature: response.temperature,
        humidity: response.humidity,
        pressure: response.pressure,
        pm1: response.pm1,
        pm25: response.pm25,
        pm10: response.pm10,
        windSpeedMax: response.windSpeedMax,
        windSpeedAvg: response.windSpeedAvg,
        precipitation: response.precipitation,
        timestamp: response.timestamp.toDate(),
      );
}
