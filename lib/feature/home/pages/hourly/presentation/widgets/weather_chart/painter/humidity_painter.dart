import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/base/line_chart_painter.dart';

class HumidityPainter extends LineChartPainter<int, double> {
  final List<double> humiditySpots;
  final List<int> timeSpots;

  HumidityPainter({
    required this.humiditySpots,
    required this.timeSpots,
    required String unit,
  }) : super(
          xSpots: timeSpots,
          ySpots: humiditySpots,
          lineColor: const Color(0xff67e4dc),
          dotBorderColor: const Color(0xff67e4dc),
          dotFillColor: const Color(0xff67e4dc),
          unit: unit,
          topOffset: 32,
          bottomOffset: 12,
        );
}
