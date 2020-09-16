import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

class ChartConstants {
  static final xAxisTitlesHeight = 50.0;
  static final tempChartHeight = 100.0;
  static final rainChartHeight = 100.0;
  static final avgWindChartHeight = 60.0;
  static final maxWindChartHeight = 60.0;
  static final humidityChartHeight = 100.0;
  static final airPollutionChartHeight = 150.0;

  static final spotWidth = 60.0;
  static final verticalDividerWidth = 1.0;
  static final horizontalDividerWidth = 0.5;

  static final dividerColor = Colors.grey[300];

  static final heights = KtList.of(
    xAxisTitlesHeight,
    tempChartHeight,
    rainChartHeight,
    maxWindChartHeight,
    avgWindChartHeight,
    airPollutionChartHeight,
  );

  static final leftTitles = KtList.of(
    RawString('Godzina'),
    RawString('Temperatura'),
    RawString('Opady'),
    RawString('Porywy\nwiatru'),
    RawString('Prędkość\nwiatru'),
    RawString('Smog'),
  );
}
