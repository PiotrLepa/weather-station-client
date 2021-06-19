import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class RainPainter extends CustomPainter {
  static final _barPaint = Paint()
    ..color = const Color(0xff27C4FF)
    ..style = PaintingStyle.fill;

  final _pixelCalculator = ChartPixelCalculator<double>();

  final KtList<double> rainSpots;
  final KtList<int> timeSpots;
  final String unit;

  RainPainter({
    required this.rainSpots,
    required this.timeSpots,
    required this.unit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minY: 0,
      maxY: rainSpots.max()!,
      topOffSet: 24,
    );
    _drawBars(canvas, size);
    _drawValues(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as RainPainter;
    return oldPainter.rainSpots != rainSpots ||
        oldPainter.timeSpots != timeSpots;
  }

  void _drawBars(Canvas canvas, Size size) {
    final path = Path();

    final barWidth =
        _pixelCalculator.getPixelX(1) - _pixelCalculator.getPixelX(0);
    final halfBarWidth = barWidth / 2;

    for (var i = 0; i < rainSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);
      final y = _pixelCalculator.getPixelY(rainSpots[i]);

      path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          y,
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(path, _barPaint);
  }

  void _drawValues(Canvas canvas) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (var i = 0; i < rainSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);
      final y = _pixelCalculator.getPixelY(rainSpots[i]);

      final textSpan = TextSpan(
        text: '${rainSpots[i]} $unit',
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
