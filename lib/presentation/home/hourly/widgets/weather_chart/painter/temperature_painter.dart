import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/base/line_chart_painter.dart';

class TemperaturePainter extends LineChartPainter<int, double> {
  final KtList<double> tempSpots;
  final KtList<int> timeSpots;

  TemperaturePainter({
    required this.tempSpots,
    required this.timeSpots,
    required String unit,
  }) : super(
          xSpots: timeSpots,
          ySpots: tempSpots,
          lineColor: const Color(0xfff0c419),
          unit: unit,
          topOffset: 24,
          bottomOffset: 24,
        );
}
