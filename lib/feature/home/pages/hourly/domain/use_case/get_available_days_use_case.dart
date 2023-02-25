import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/repository/weather_repository.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/model/available_days.dart';

@injectable
class GetAvailableDaysUseCase {
  final WeatherRepository _repository;

  GetAvailableDaysUseCase(this._repository);

  Future<AvailableDays> invoke() => _repository.getAvailableDays();
}
