import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_pixel_utils.dart';

class VerticalDividersPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int>();
  final List<int> xSpots;

  final _verticalDividerPaint = Paint()
    ..color = dividerColor
    ..strokeWidth = verticalDividerWidth;

  final _windVerticalDividerPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = verticalDividerWidth;

  VerticalDividersPainter({
    required this.xSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(size);
    _drawVerticalLines(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as VerticalDividersPainter;
    return oldPainter.xSpots != xSpots;
  }

  void _drawVerticalLines(Canvas canvas, Size size) {
    final heightAboveWind = [
      xAxisTitlesHeight,
      tempHeight,
      rainHeight,
    ].reduce((sum, value) => sum + value);
    final windHeight = [
      maxWindHeight,
      avgWindHeight,
    ].reduce((sum, value) => sum + value);

    for (var i = 0; i < xSpots.length - 1; i++) {
      final currentX = _pixelCalculator.getPixelX(i);
      final nextX = _pixelCalculator.getPixelX(i + 1);
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
