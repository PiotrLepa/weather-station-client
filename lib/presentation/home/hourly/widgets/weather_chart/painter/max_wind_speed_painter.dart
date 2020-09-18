import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class MaxWindSpeedPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> speedSpots;
  final KtList<int> timeSpots;

  final _containerPaint = Paint()
    ..color = Colors.grey[300]
    ..style = PaintingStyle.fill;

  MaxWindSpeedPainter({
    @required this.speedSpots,
    @required this.timeSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: timeSpots.min(),
      maxX: timeSpots.max(),
      minY: speedSpots.min(),
      maxY: speedSpots.max(),
    );
    _drawContainer(canvas, size);
    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as MaxWindSpeedPainter;
    return oldPainter.speedSpots != speedSpots ||
        oldPainter.timeSpots != timeSpots;
  }

  void _drawContainer(Canvas canvas, Size size) {
    final Path path = Path();

    final barWidth = _pixelCalculator.getPixelX(timeSpots[1]) -
        _pixelCalculator.getPixelX(timeSpots[0]);
    final halfBarWidth = barWidth / 2;

    for (int i = 0; i < speedSpots.size; i++) {
      final x = _pixelCalculator.getPixelX(timeSpots[i]);

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
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    for (int i = 0; i < speedSpots.size; i++) {
      final double x = _pixelCalculator.getPixelX(timeSpots[i]);

      var text;
      if (speedSpots[i] > 15.0) {
        text = 'Umiar.';
      } else if (speedSpots[i] > 20.0) {
        text = 'Silne';
      } else {
        text = 'Słabe';
      }

      final textSpan = TextSpan(
        text: text,
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
