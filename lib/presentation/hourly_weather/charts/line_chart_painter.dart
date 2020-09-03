import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class LineChartPainter extends CustomPainter {
  final KtList<int> temps;
  final KtList<int> hours;

  final viewSize = Size(400, 200);

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

  LineChartPainter({
    @required this.temps,
    @required this.hours,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var barPath = _generateLinePath();
    canvas.drawPath(barPath, _linePaint);
    drawDots(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path _generateLinePath() {
    final Path path = Path();

    final double x = getPixelX(hours[0], viewSize);
    final double y = getPixelY(temps[0], viewSize);

    path.moveTo(x, y);

    for (int i = 1; i < temps.size; i++) {
      path.lineTo(
        getPixelX(hours[i], viewSize),
        getPixelY(temps[i], viewSize),
      );
    }

    return path;
  }

  void drawDots(Canvas canvas) {
    final circleRadius = 5.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    for (int i = 0; i < temps.size; i++) {
      final double x = getPixelX(hours[i], viewSize);
      final double y = getPixelY(temps[i], viewSize);

      canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
      canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);

      final textSpan = TextSpan(
        text: temps[i].toString(),
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );
      textPainter.layout();

      final offset = Offset(x - textPainter.width / 2, y - 25);
      textPainter.paint(canvas, offset);
    }
  }

  double getPixelX(int spotX, Size chartSize) {
    final double difference = hours.max() - hours.min().toDouble();
    if (difference == 0.0) {
      return 0;
    }
    return (((spotX - hours.min()) / difference) * chartSize.width);
  }

  double getPixelY(int spotY, Size chartSize) {
    final double difference = temps.max() - temps.min().toDouble();
    if (difference == 0.0) {
      return chartSize.height;
    }

    double y = ((spotY - temps.min()) / difference) * chartSize.height;
    return chartSize.height - y;
  }
}
