import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/model/available_days_response.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/model/available_days.dart';

@lazySingleton
class AvailableDaysConverter {
  AvailableDays toDomain(AvailableDaysResponse response) => AvailableDays(
        days: response.days,
      );
}
