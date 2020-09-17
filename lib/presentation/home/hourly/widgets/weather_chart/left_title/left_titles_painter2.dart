import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/chart_title.dart';

class LeftTitlesPainter2 extends CustomPainter {
  final KtList<ChartTitle> titles;

  LeftTitlesPainter2({
    @required this.titles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    titles.forEach((title) {
      title.draw(canvas, size);
    });
  }

  @override
  bool shouldRepaint(LeftTitlesPainter2 oldDelegate) {
    return oldDelegate.titles != titles;
  }
}
