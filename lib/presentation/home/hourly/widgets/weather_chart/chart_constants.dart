import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/legend_chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/normal_chart_title.dart';

class ChartConstants {
  static final xAxisTitlesHeight = 50.0;
  static final tempHeight = 100.0;
  static final rainHeight = 100.0;
  static final avgWindHeight = 60.0;
  static final maxWindHeight = 60.0;
  static final humidityChartHeight = 100.0;
  static final airPollutionHeight = 200.0;

  static final spotWidth = 60.0;
  static final verticalDividerWidth = 1.0;
  static final horizontalDividerWidth = 0.5;

  static final backgroundColor = Colors.white;
  static final dividerColor = Colors.grey[300];
  static final airPollutionPm1Color = Colors.deepPurple[200];
  static final airPollutionPm25Color = Colors.red[200];
  static final airPollutionPm10Color = Colors.green[200];

  static final heights = KtList.of(
    xAxisTitlesHeight,
    tempHeight,
    rainHeight,
    maxWindHeight,
    avgWindHeight,
    airPollutionHeight,
  );

  static final leftTitles = KtList.of(
    NormalChartTitle(RawString('Godzina'), xAxisTitlesHeight),
    NormalChartTitle(RawString('Temperatura'), tempHeight),
    NormalChartTitle(RawString('Opady'), rainHeight),
    NormalChartTitle(RawString('Porywy\nwiatru'), maxWindHeight),
    NormalChartTitle(RawString('Prędkość\nwiatru'), avgWindHeight),
    LegendChartTitle(
      RawString('Smog'),
      airPollutionHeight,
      KtList.of(
        ChartLegend(RawString('Pm 1'), airPollutionPm1Color),
        ChartLegend(RawString('Pm 25'), airPollutionPm25Color),
        ChartLegend(RawString('Pm 10'), airPollutionPm10Color),
      ),
    ),
  );
}
