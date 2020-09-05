import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class RainPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> rains;
  final KtList<int> dateMillis;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.amber
    ..strokeWidth = 2;

  final _dotBorderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.black
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  final _dotFillPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  RainPainter({
    @required this.rains,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: rains.min(),
      maxY: rains.max(),
      topOffSet: 24,
    );
    _drawBars(canvas, size);
    // _drawDots(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawBars(Canvas canvas, Size size) {
    final Path path = Path();

    for (int i = 0; i < rains.size; i++) {
      final x = pixelCalculator.getPixelX(dateMillis[i]);
      final y = pixelCalculator.getPixelY(rains[i]);
      final x2 =
          pixelCalculator.getPixelX(dateMillis[i + 1 < rains.size ? i + 1 : i]);
      final y2 =
          pixelCalculator.getPixelY(rains[i + 1 < rains.size ? i + 1 : i]);
      path.addRect(Rect.fromLTRB(x, y, x2, size.height));
    }

    canvas.drawPath(path, _linePaint);
  }

  void _drawDots(Canvas canvas) {
    final circleRadius = 5.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    for (int i = 0; i < rains.size; i++) {
      final double x = pixelCalculator.getPixelX(dateMillis[i]);
      final double y = pixelCalculator.getPixelY(rains[i]);

      canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
      canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);

      final textSpan = TextSpan(
        text: rains[i].toString(),
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
