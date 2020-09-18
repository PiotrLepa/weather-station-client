import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class LineChartPainter<X extends num, Y extends num> extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<X, Y>();

  final KtList<X> xSpots;
  final KtList<Y> ySpots;
  final Color lineColor;
  final Color dotBorderColor;
  final Color dotFillColor;
  final String unit;
  final int topOffset;
  final int bottomOffset;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  final _dotBorderPaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  final _dotFillPaint = Paint()..style = PaintingStyle.fill;

  LineChartPainter({
    @required this.ySpots,
    @required this.xSpots,
    @required this.lineColor,
    this.dotBorderColor,
    this.dotFillColor,
    this.unit = '',
    this.topOffset = 0,
    this.bottomOffset = 0,
  }) {
    _linePaint.color = lineColor;
    _dotBorderPaint.color = dotBorderColor ?? Colors.black;
    _dotFillPaint.color = dotFillColor ?? Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: xSpots.min(),
      maxX: xSpots.max(),
      minY: ySpots.min(),
      maxY: ySpots.max(),
      topOffSet: topOffset,
      bottomOffSet: bottomOffset,
    );
    _drawLines(canvas);
    _drawDots(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as LineChartPainter;
    return oldPainter.ySpots != ySpots || oldPainter.xSpots != xSpots;
  }

  void _drawLines(Canvas canvas) {
    final Path path = Path();

    final double x = _pixelCalculator.getPixelX(xSpots[0]);
    final double y = _pixelCalculator.getPixelY(ySpots[0]);

    path.moveTo(x, y);

    for (int i = 1; i < ySpots.size; i++) {
      path.lineTo(
        _pixelCalculator.getPixelX(xSpots[i]),
        _pixelCalculator.getPixelY(ySpots[i]),
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

    for (int i = 0; i < ySpots.size; i++) {
      final double x = _pixelCalculator.getPixelX(xSpots[i]);
      final double y = _pixelCalculator.getPixelY(ySpots[i]);

      canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
      canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);

      final textSpan = TextSpan(
        text: '${ySpots[i]}$unit',
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
