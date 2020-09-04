import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class LineChartPainter extends CustomPainter {
  final KtList<int> temps;
  final KtList<int> hours;

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

  final _verticalDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  LineChartPainter({
    @required this.temps,
    @required this.hours,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final tempTopOffSet = 80;
    final tempBottomOffSet = 50;
    _drawTopTitles(canvas, size);
    _drawLines(canvas, size, tempTopOffSet, tempBottomOffSet);
    _drawDots(canvas, size, tempTopOffSet, tempBottomOffSet);
    _drawVerticalLines(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawTopTitles(Canvas canvas, Size chartSize) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );

    for (int i = 0; i < hours.size; i++) {
      final double x = getPixelX(hours[i], chartSize);

      final textSpan = TextSpan(
        text: hours[i].toString(),
        style: textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(x - textPainter.width / 2, 0);
      textPainter.paint(canvas, offset);
    }
  }

  void _drawLines(
    Canvas canvas,
    Size chartSize,
    int topOffSet,
    int bottomOffSet,
  ) {
    final Path path = Path();

    final double x = getPixelX(hours[0], chartSize);
    final double y = getPixelY(temps[0], chartSize, topOffSet, bottomOffSet);

    path.moveTo(x, y);

    for (int i = 1; i < temps.size; i++) {
      path.lineTo(
        getPixelX(hours[i], chartSize),
        getPixelY(temps[i], chartSize, topOffSet, bottomOffSet),
      );
    }

    canvas.drawPath(path, _linePaint);
  }

  void _drawDots(
    Canvas canvas,
    Size chartSize,
    int topOffSet,
    int bottomOffSet,
  ) {
    final circleRadius = 5.0;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
    );

    for (int i = 0; i < temps.size; i++) {
      final double x = getPixelX(hours[i], chartSize);
      final double y = getPixelY(temps[i], chartSize, topOffSet, bottomOffSet);

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
      )
        ..layout();

      final offset = Offset(x - textPainter.width / 2, y - 25);
      textPainter.paint(canvas, offset);
    }
  }

  void _drawVerticalLines(Canvas canvas, Size chartSize) {
    // final top = Offset(0, 0);
    // final bottom = Offset(0, chartSize.height);

    // canvas.drawLine(top, bottom, _verticalDividerPaint);

    for (int i = 0; i < hours.size - 1; i++) {
      final currentX = getPixelX(hours[i], chartSize);
      final nextX = getPixelX(hours[i + 1], chartSize);
      final difference = nextX - currentX;
      final centerX = currentX + difference / 2;

      final top = Offset(centerX, 0);
      final bottom = Offset(centerX, chartSize.height);

      canvas.drawLine(top, bottom, _verticalDividerPaint);
    }
  }

  double getPixelX(int spotX, Size chartSize) {
    final double difference = hours.max() - hours.min().toDouble();
    if (difference == 0.0) {
      return 0;
    }

    return (((spotX - hours.min()) / difference) * chartSize.width);
  }

  double getPixelY(int spotY,
      Size chartSize, [
        int topOffSet = 0,
        int bottomOffSet = 0,
      ]) {
    final double difference = temps.max() - temps.min().toDouble();
    if (difference == 0.0) {
      return chartSize.height + bottomOffSet; // TODO check
    }

    double y = ((spotY - temps.min()) / difference) *
        (chartSize.height - topOffSet - bottomOffSet);
    return chartSize.height - y - bottomOffSet;
  }
}
