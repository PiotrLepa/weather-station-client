import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/base/line_chart_painter.dart';

class HumidityPainter extends LineChartPainter<int, double> {
  final KtList<double> humiditySpots;
  final KtList<int> timeSpots;

  HumidityPainter({
    @required this.humiditySpots,
    @required this.timeSpots,
    @required String unit,
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
