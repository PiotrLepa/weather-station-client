import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/model/available_days/available_days_model.dart';
import 'package:weather_station/domain/entity/available_days/available_days.dart';

@lazySingleton
class AvailableDaysEntityConverter
    implements Converter<AvailableDaysModel, AvailableDays> {
  @override
  AvailableDays convert(AvailableDaysModel model) =>
      AvailableDays(
        days: model.days,
      );
}
