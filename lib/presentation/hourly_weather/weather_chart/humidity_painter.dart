import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class HumidityPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> humidity;
  final KtList<int> dateMillis;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xff67e4dc)
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

  HumidityPainter({
    @required this.humidity,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: humidity.min(),
      maxY: humidity.max(),
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

    final double x = _pixelCalculator.getPixelX(dateMillis[0]);
    final double y = _pixelCalculator.getPixelY(humidity[0]);

    path.moveTo(x, y);

    for (int i = 1; i < humidity.size; i++) {
      path.lineTo(
        _pixelCalculator.getPixelX(dateMillis[i]),
        _pixelCalculator.getPixelY(humidity[i]),
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

    for (int i = 0; i < humidity.size; i++) {
      final double x = _pixelCalculator.getPixelX(dateMillis[i]);
      final double y = _pixelCalculator.getPixelY(humidity[i]);

      canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
      canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);

      final textSpan = TextSpan(
        text: '${humidity[i]}%',
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
