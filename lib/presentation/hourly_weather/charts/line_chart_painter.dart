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

  LineChartPainter({
    @required this.temps,
    @required this.hours,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var barPath = _generateNormalBarPath();

    canvas.drawPath(barPath, _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  Path _generateNormalBarPath() {
    final viewSize = Size(400, 200);
    final Path path = Path();
    final int size = temps.size;

    final double x = getPixelX(hours[0], viewSize);
    final double y = getPixelY(temps[0], viewSize);

    path.moveTo(x, y);

    for (int i = 1; i < size; i++) {
      path.lineTo(
        getPixelX(hours[i], viewSize),
        getPixelY(temps[i], viewSize),
      );
    }

    return path;
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
