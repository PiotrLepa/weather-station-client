import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class TemperaturePainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, int>();

  final KtList<int> temps;
  final KtList<int> dateMillis;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xfff0c419)
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

  TemperaturePainter({
    @required this.temps,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: temps.min(),
      maxY: temps.max(),
      topOffSet: 24,
      bottomOffSet: 24,
    );
    _drawLines(canvas);
    _drawDots(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawLines(Canvas canvas) {
    final Path path = Path();

    final double x = pixelCalculator.getPixelX(dateMillis[0]);
    final double y = pixelCalculator.getPixelY(temps[0]);

    path.moveTo(x, y);

    for (int i = 1; i < temps.size; i++) {
      path.lineTo(
        pixelCalculator.getPixelX(dateMillis[i]),
        pixelCalculator.getPixelY(temps[i]),
      );
    }

    canvas.drawPath(path, _linePaint);
  }

  void _drawDots(Canvas canvas) {
    final circleRadius = 5.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    for (int i = 0; i < temps.size; i++) {
      final double x = pixelCalculator.getPixelX(dateMillis[i]);
      final double y = pixelCalculator.getPixelY(temps[i]);

      canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
      canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);

      final textSpan = TextSpan(
        text: '${temps[i]}°',
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
