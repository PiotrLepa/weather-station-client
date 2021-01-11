import 'package:injectable/injectable.dart';
import 'package:weather_station/core/extension/iterable_extension.dart';
import 'package:weather_station/data/model/available_days/available_days_model.dart';
import 'package:weather_station/domain/entity/available_days/available_days.dart';

@lazySingleton
class AvailableDaysConverter {
  AvailableDays toEntity(AvailableDaysModel model) => AvailableDays(
        days: model.days.toKtList(),
      );
}
