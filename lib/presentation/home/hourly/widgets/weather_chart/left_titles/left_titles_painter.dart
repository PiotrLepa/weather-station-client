import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';

class LeftTitlesPainter extends CustomPainter {
  final BuildContext context;
  final KtList<ChartTitle> titles;

  LeftTitlesPainter({
    @required this.context,
    @required this.titles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double previousHeights = 0;
    titles.forEach((title) {
      title.draw(context, canvas, size, previousHeights);
      previousHeights += title.height;
    });
  }

  @override
  bool shouldRepaint(LeftTitlesPainter oldDelegate) {
    return oldDelegate.titles != titles;
  }
}
