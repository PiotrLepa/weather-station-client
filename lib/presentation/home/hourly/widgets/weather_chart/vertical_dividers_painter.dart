import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class VerticalDividersPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, int>();
  final KtList<int> xSpots;

  final _topVerticalDividerPaint = Paint()
    ..color = ChartConstants.dividerColor
    ..strokeWidth = ChartConstants.verticalDividerWidth;

  final _bottomVerticalDividerPaint = Paint()
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
    return false;
  }

  void _drawVerticalLines(Canvas canvas, Size size) {
    final firstColorHeight = KtList.of(
      ChartConstants.xAxisTitlesHeight,
      ChartConstants.tempChartHeight,
      ChartConstants.rainChartHeight,
    ).sum();

    for (int i = 0; i < xSpots.size - 1; i++) {
      final currentX = pixelCalculator.getPixelX(xSpots[i]);
      final nextX = pixelCalculator.getPixelX(xSpots[i + 1]);
      final difference = nextX - currentX;
      final centerX = currentX + difference / 2;

      final top1 = Offset(centerX, 0);
      final bottom1 = Offset(centerX, firstColorHeight);
      canvas.drawLine(top1, bottom1, _topVerticalDividerPaint);

      final top2 = Offset(centerX, firstColorHeight);
      final bottom2 = Offset(centerX, size.height);
      canvas.drawLine(top2, bottom2, _bottomVerticalDividerPaint);
    }
  }
}
