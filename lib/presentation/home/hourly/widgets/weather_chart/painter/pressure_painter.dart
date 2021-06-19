import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/base/line_chart_painter.dart';

class PressurePainter extends LineChartPainter<int, int> {
  final KtList<int> pressureSpots;
  final KtList<int> timeSpots;

  PressurePainter({
    required this.pressureSpots,
    required this.timeSpots,
  }) : super(
          xSpots: timeSpots,
          ySpots: pressureSpots,
          lineColor: const Color(0xff00347b),
          dotBorderColor: const Color(0xff00347b),
          dotFillColor: Colors.white,
          topOffset: 32,
          bottomOffset: 12,
        );
}
