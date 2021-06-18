import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/date_time/date_time_formatter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class XAxisTitlesPainter extends CustomPainter {
  static const _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _dateFormatter = getIt<DateTimeFormatter>();
  final _pixelCalculator = ChartPixelCalculator<int>();

  final KtList<int> xSpots;

  XAxisTitlesPainter({
    required this.xSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(size);
    _drawTopTitles(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as XAxisTitlesPainter;
    return oldPainter.xSpots != xSpots;
  }

  void _drawTopTitles(Canvas canvas, Size size) {
    for (var i = 0; i < xSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);

      final date = DateTime.fromMillisecondsSinceEpoch(xSpots[i]);
      final textSpan = TextSpan(
        text: _dateFormatter.format(date, DateTimeFormatter.defaultHourPattern),
        style: _titleStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(
        x - textPainter.width / 2,
        (size.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }
}
