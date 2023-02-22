import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:weather_station_client/extensions/date_time_extensions.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';

@injectable
class GetHourlyWeatherUseCase {
  static const _decimalPrecision = 1;

  final WeatherRepository _repository;

  GetHourlyWeatherUseCase(this._repository);

  Future<List<Weather>> invoke(DateTime day) => _repository
      .getWeathersForDay(day)
      .then((weathers) => _calculateHourlyWeather(weathers));

  List<Weather> _calculateHourlyWeather(List<Weather> weathers) => weathers
      .map((weather) => weather.copyWith(
            timestamp: _setHourPrecisionToDate(weather.timestamp),
          ))
      .groupBy((weather) => weather.timestamp)
      .values
      .map((weather) => _sumWeathersFromHour(weather))
      .toList();

  DateTime _setHourPrecisionToDate(DateTime dateTime) => dateTime.copyWith(
        minute: 0,
        second: 0,
        millisecond: 0,
      );

  Weather _sumWeathersFromHour(List<Weather> weathers) => Weather(
        temperature:
            _calculateAvgDouble(weathers.map((weather) => weather.temperature))
                .toPrecision(_decimalPrecision),
        humidity:
            _calculateAvgDouble(weathers.map((weather) => weather.humidity))
                .toPrecision(_decimalPrecision),
        pressure: _calculateAvgInt(weathers.map((weather) => weather.pressure)),
        pm1: _calculateAvgInt(weathers.map((weather) => weather.pm1)),
        pm25: _calculateAvgInt(weathers.map((weather) => weather.pm25)),
        pm10: _calculateAvgInt(weathers.map((weather) => weather.pm10)),
        windSpeedMax:
            weathers.map((weather) => weather.windSpeedMax).reduce(max),
        windSpeedAvg:
            _calculateAvgDouble(weathers.map((weather) => weather.windSpeedAvg))
                .toPrecision(_decimalPrecision),
        precipitation:
            _calculateAvgDouble(
                weathers.map((weather) => weather.precipitation))
            .toPrecision(_decimalPrecision),
        timestamp: weathers.first.timestamp,
      );

  int _calculateAvgInt(Iterable<int> values) =>
      (values.reduce((sum, element) => sum + element) / values.length).round();

  double _calculateAvgDouble(Iterable<double> values) =>
      values.reduce((sum, element) => sum + element) / values.length;
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
