import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class RainPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> rains;
  final KtList<int> dateMillis;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xff27C4FF)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  RainPainter({
    @required this.rains,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: rains.min(),
      maxY: rains.max(),
      topOffSet: 24,
    );
    _drawBars(canvas, size);
    _drawValues(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawBars(Canvas canvas, Size size) {
    final Path path = Path();

    final barWidth = _pixelCalculator.getPixelX(dateMillis[1]) -
        _pixelCalculator.getPixelX(dateMillis[0]);
    final halfBarWidth = barWidth / 2;

    for (int i = 0; i < rains.size; i++) {
      final x = _pixelCalculator.getPixelX(dateMillis[i]);
      final y = _pixelCalculator.getPixelY(rains[i]);
      path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          y - 1,
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(path, _linePaint);
  }

  void _drawValues(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (int i = 0; i < rains.size; i++) {
      final double x = _pixelCalculator.getPixelX(dateMillis[i]);
      final double y = _pixelCalculator.getPixelY(rains[i]);

      final textSpan = TextSpan(
        text: '${rains[i]} mm',
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(x - textPainter.width / 2, y - 25);
      textPainter.paint(canvas, offset);
    }
  }
}
