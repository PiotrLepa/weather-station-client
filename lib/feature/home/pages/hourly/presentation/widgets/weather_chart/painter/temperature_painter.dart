import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/base/line_chart_painter.dart';

class TemperaturePainter extends LineChartPainter<int, double> {
  final List<double> tempSpots;
  final List<int> timeSpots;

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
