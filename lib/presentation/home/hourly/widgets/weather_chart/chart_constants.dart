import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class ChartConstants {
  static final xAxisTitlesHeight = 50.0;
  static final tempHeight = 100.0;
  static final rainHeight = 100.0;
  static final avgWindHeight = 60.0;
  static final maxWindHeight = 60.0;
  static final humidityHeight = 100.0;
  static final airPollutionHeight = 200.0;
  static final pressureHeight = 100.0;

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
    humidityHeight,
    airPollutionHeight,
    pressureHeight,
  );
}
