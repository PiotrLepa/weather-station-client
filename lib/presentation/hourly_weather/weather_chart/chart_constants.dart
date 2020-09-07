import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

class ChartConstants {
  static final spotWidth = 60.0;
  static final xAxisTitlesHeight = 50.0;
  static final tempChartHeight = 100.0;
  static final rainChartHeight = 100.0;
  static final windChartHeight = 150.0;
  static final verticalDividerWidth = 1.0;

  static final heights = KtList.of(
    xAxisTitlesHeight,
    tempChartHeight,
    rainChartHeight,
    windChartHeight,
  );

  static final leftTitles = KtList.of(
    RawString('Godzina'),
    RawString('Temperatura'),
    RawString('Opady'),
    RawString('Prędkość\nwiatru'),
  );
}
