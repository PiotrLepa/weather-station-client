import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class VerticalDividersPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, int>();
  final KtList<int> xSpots;

  final _verticalDividerPaint = Paint()
    ..color = ChartConstants.dividerColor
    ..strokeWidth = ChartConstants.verticalDividerWidth;

  final _windVerticalDividerPaint = Paint()
    ..color = Colors.white
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
    final oldPainter = oldDelegate as VerticalDividersPainter;
    return oldPainter.xSpots != xSpots;
  }

  void _drawVerticalLines(Canvas canvas, Size size) {
    final heightAboveWind = KtList.of(
      ChartConstants.xAxisTitlesHeight,
      ChartConstants.tempHeight,
      ChartConstants.rainHeight,
    ).sum();
    final windHeight = KtList.of(
      ChartConstants.maxWindHeight,
      ChartConstants.avgWindHeight,
    ).sum();

    for (int i = 0; i < xSpots.size - 1; i++) {
      final currentX = pixelCalculator.getPixelX(xSpots[i]);
      final nextX = pixelCalculator.getPixelX(xSpots[i + 1]);
      final difference = nextX - currentX;
      final centerX = currentX + difference / 2;

      final top1 = Offset(centerX, 0);
      final bottom1 = Offset(centerX, size.height);
      canvas.drawLine(top1, bottom1, _verticalDividerPaint);

      final top2 = Offset(centerX, heightAboveWind);
      final bottom2 = Offset(centerX, heightAboveWind + windHeight);
      canvas.drawLine(top2, bottom2, _windVerticalDividerPaint);
    }
  }
}
