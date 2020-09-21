import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/base/line_chart_painter.dart';

class TemperaturePainter extends LineChartPainter<int, int> {
  final KtList<int> tempSpots;
  final KtList<int> timeSpots;
  final String unit;

  TemperaturePainter({
    @required this.tempSpots,
    @required this.timeSpots,
    @required this.unit,
  }) : super(
          xSpots: timeSpots,
          ySpots: tempSpots,
          lineColor: const Color(0xfff0c419),
          unit: unit,
          topOffset: 24,
          bottomOffset: 24,
        );
}
