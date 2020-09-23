import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

const xAxisTitlesHeight = 50.0;
const tempHeight = 100.0;
const rainHeight = 100.0;
const avgWindHeight = 60.0;
const maxWindHeight = 60.0;
const humidityHeight = 100.0;
const airPollutionHeight = 200.0;
const pressureHeight = 100.0;

const spotWidth = 60.0;
const verticalDividerWidth = 1.0;
const horizontalDividerWidth = 0.5;

const backgroundColor = Colors.white;
final dividerColor = Colors.grey[300];
final airPollutionPm1Color = Colors.deepPurple[200];
final airPollutionPm25Color = Colors.red[200];
final airPollutionPm10Color = Colors.green[200];

final heights = KtList.of(
  xAxisTitlesHeight,
  tempHeight,
  rainHeight,
  maxWindHeight,
  avgWindHeight,
  humidityHeight,
  airPollutionHeight,
  pressureHeight,
);
