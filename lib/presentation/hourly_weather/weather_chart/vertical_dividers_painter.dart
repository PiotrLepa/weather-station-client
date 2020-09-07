import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class VerticalDividersPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, int>();
  final KtList<int> xSpots;

  final _verticalDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = ChartConstants.verticalDividerWidth;

  VerticalDividersPainter({
    @required this.xSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    pixelCalculator.initialize(
      size,
      minX: xSpots.min(),
      maxX: xSpots.max(),
    );
    _drawVerticalLines(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawVerticalLines(Canvas canvas, Size size) {
    // final top = Offset(0, 0);
    // final bottom = Offset(0, chartSize.height);

    // canvas.drawLine(top, bottom, _verticalDividerPaint);

    for (int i = 0; i < xSpots.size - 1; i++) {
      final currentX = pixelCalculator.getPixelX(xSpots[i]);
      final nextX = pixelCalculator.getPixelX(xSpots[i + 1]);
      final difference = nextX - currentX;
      final centerX = currentX + difference / 2;

      final top = Offset(centerX, 0);
      final bottom = Offset(centerX, size.height);

      canvas.drawLine(top, bottom, _verticalDividerPaint);
    }
  }
}
