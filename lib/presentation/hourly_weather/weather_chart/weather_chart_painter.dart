import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class WeatherChartPainter extends CustomPainter {
  final tempPixels = ChartPixelCalculator<int, int>();
  final rainPixels = ChartPixelCalculator<int, double>();

  final KtList<int> temps;
  final KtList<double> rains;
  final KtList<int> dateMillis;

  final _tempLinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.amber
    ..strokeWidth = 2;

  final _rainBarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..style = PaintingStyle.fill
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

  WeatherChartPainter({
    @required this.temps,
    @required this.rains,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tempSize = Size(size.width, 150);
    final rainSize = Size(size.width, 100);
    tempPixels.initialize(
      tempSize,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: temps.min(),
      maxY: temps.max(),
      topOffSet: 24,
      bottomOffSet: 24,
    );
    rainPixels.initialize(
      rainSize,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: rains.min(),
      maxY: rains.max(),
      topOffSet: 24,
      bottomOffSet: 24,
    );

    _drawTempLines(canvas);
    _drawTempDots(canvas);
    _drawRainBars(canvas, rainSize);
    _drawRainValues(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawTempLines(Canvas canvas) {
    final Path path = Path();

    final double x = tempPixels.getPixelX(dateMillis[0]);
    final double y = tempPixels.getPixelY(temps[0]);

    path.moveTo(x, y);

    for (int i = 1; i < temps.size; i++) {
      path.lineTo(
        tempPixels.getPixelX(dateMillis[i]),
        tempPixels.getPixelY(temps[i]),
      );
    }

    canvas.drawPath(path, _tempLinePaint);
  }

  void _drawTempDots(Canvas canvas) {
    final circleRadius = 5.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    for (int i = 0; i < temps.size; i++) {
      final double x = tempPixels.getPixelX(dateMillis[i]);
      final double y = tempPixels.getPixelY(temps[i]);

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

  void _drawRainBars(Canvas canvas, Size size) {
    final Path path = Path();

    final barWidth = rainPixels.getPixelX(dateMillis[1]) -
        rainPixels.getPixelX(dateMillis[0]);
    final halfBarWidth = barWidth / 2;

    for (int i = 0; i < rains.size; i++) {
      final x = rainPixels.getPixelX(dateMillis[i]);
      final y = rainPixels.getPixelY(rains[i]) + 150;
      path.addRect(Rect.fromLTRB(
          x - halfBarWidth, y, x + halfBarWidth, size.height + 150));
    }

    canvas.drawPath(path, _rainBarPaint);
  }

  void _drawRainValues(Canvas canvas) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (int i = 0; i < rains.size; i++) {
      final double x = rainPixels.getPixelX(dateMillis[i]);
      final double y = rainPixels.getPixelY(rains[i]);

      final textSpan = TextSpan(
        text: '${rains[i]} mm',
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(x - textPainter.width / 2, y - 25 + 150);
      textPainter.paint(canvas, offset);
    }
  }
}
