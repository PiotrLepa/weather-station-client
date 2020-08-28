library weather;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
abstract class Weather with _$Weather {
  const factory Weather({
    @required double temperature,
    @required double humidity,
    @required int pressure,
    @required double pm1,
    @required double pm25,
    @required double pm10,
    @required double windSpeedMax,
    @required double windSpeedAvg,
    @required double rainGauge,
    @required String location,
    @required DateTime date,
  }) = _Weather;
}
