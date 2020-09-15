import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class MaxWindSpeedPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> speeds;
  final KtList<int> dateMillis;

  final _containerPaint = Paint()
    ..color = Colors.grey[300]
    ..style = PaintingStyle.fill;

  MaxWindSpeedPainter({
    @required this.speeds,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: speeds.min(),
      maxY: speeds.max(),
    );
    _drawContainer(canvas, size);
    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as MaxWindSpeedPainter;
    return oldPainter.speeds != speeds || oldPainter.dateMillis != dateMillis;
  }

  void _drawContainer(Canvas canvas, Size size) {
    final Path path = Path();

    final barWidth = _pixelCalculator.getPixelX(dateMillis[1]) -
        _pixelCalculator.getPixelX(dateMillis[0]);
    final halfBarWidth = barWidth / 2;

    for (int i = 0; i < speeds.size; i++) {
      final x = _pixelCalculator.getPixelX(dateMillis[i]);

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

    for (int i = 0; i < speeds.size; i++) {
      final double x = _pixelCalculator.getPixelX(dateMillis[i]);

      var text;
      if (speeds[i] > 15.0) {
        text = 'Umiar.';
      } else if (speeds[i] > 20.0) {
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
