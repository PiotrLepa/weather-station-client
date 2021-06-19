import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class AvgWindSpeedPainter extends CustomPainter {
  static final _containerPaint = Paint()
    ..color = Colors.grey.shade300
    ..style = PaintingStyle.fill;

  final _pixelCalculator = ChartPixelCalculator<double>();

  final KtList<double> speedSpots;
  final KtList<int> timeSpots;
  final String unit;

  AvgWindSpeedPainter({
    required this.speedSpots,
    required this.timeSpots,
    required this.unit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minY: speedSpots.min()!,
      maxY: speedSpots.max()!,
    );
    _drawContainer(canvas, size);
    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as AvgWindSpeedPainter;
    return oldPainter.speedSpots != speedSpots ||
        oldPainter.timeSpots != timeSpots;
  }

  void _drawContainer(Canvas canvas, Size size) {
    final path = Path();

    final barWidth =
        _pixelCalculator.getPixelX(1) - _pixelCalculator.getPixelX(0);
    final halfBarWidth = barWidth / 2;

    for (var i = 0; i < speedSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);

      path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          0,
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(path, _containerPaint);
  }

  void _drawText(Canvas canvas, Size size) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (var i = 0; i < speedSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);

      final textSpan = TextSpan(
        text: '${speedSpots[i]}\n$unit',
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(
        x - textPainter.width / 2,
        (size.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }
}
