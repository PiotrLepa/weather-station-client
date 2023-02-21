import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/left_titles/chart_title.dart';

class LeftTitlesPainter extends CustomPainter {
  final BuildContext context;
  final List<ChartTitle> titles;

  LeftTitlesPainter({
    required this.context,
    required this.titles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var previousHeights = 0.0;
    for (var title in titles) {
      title.draw(context, canvas, size, previousHeights);
      previousHeights += title.itemHeight;
    }
  }

  @override
  bool shouldRepaint(LeftTitlesPainter oldDelegate) {
    return oldDelegate.titles != titles;
  }
}
