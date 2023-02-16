import 'package:injectable/injectable.dart';
import 'package:weather_station_client/extensions/date_time_extensions.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/model/available_days_response.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/model/available_days.dart';

@lazySingleton
class AvailableDaysConverter {
  AvailableDays toDomain(List<AvailableDayResponse> responseList) =>
      AvailableDays(
        days: responseList
            .map((response) => response.day.toDate().copyWith(millisecond: 0))
            .toList(),
      );
}
