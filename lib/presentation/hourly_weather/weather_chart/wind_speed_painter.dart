import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class WindSpeedPainter extends CustomPainter {
  final _pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> maxSpeeds;
  final KtList<double> avgSpeeds;
  final KtList<int> dateMillis;

  final _maxSpeedLinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.red
    ..strokeWidth = 2;

  final _avgSpeedLinePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blueGrey
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

  WindSpeedPainter({
    @required this.maxSpeeds,
    @required this.avgSpeeds,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY:
          maxSpeeds.min() < avgSpeeds.min() ? maxSpeeds.min() : avgSpeeds.min(),
      maxY:
          maxSpeeds.max() > avgSpeeds.max() ? maxSpeeds.max() : avgSpeeds.max(),
      topOffSet: 24,
      bottomOffSet: 24,
    );
    _drawMaxSpeedsLine(canvas);
    _drawAvgSpeedsLine(canvas);
    // _drawDots(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawMaxSpeedsLine(Canvas canvas) {
    final Path path = Path();

    final double x = _pixelCalculator.getPixelX(dateMillis[0]);
    final double y = _pixelCalculator.getPixelY(maxSpeeds[0]);

    path.moveTo(x, y);

    for (int i = 1; i < maxSpeeds.size; i++) {
      path.lineTo(
        _pixelCalculator.getPixelX(dateMillis[i]),
        _pixelCalculator.getPixelY(maxSpeeds[i]),
      );
    }

    canvas.drawPath(path, _maxSpeedLinePaint);
  }

  void _drawAvgSpeedsLine(Canvas canvas) {
    final Path path = Path();

    final double x = _pixelCalculator.getPixelX(dateMillis[0]);
    final double y = _pixelCalculator.getPixelY(avgSpeeds[0]);

    path.moveTo(x, y);

    for (int i = 1; i < avgSpeeds.size; i++) {
      path.lineTo(
        _pixelCalculator.getPixelX(dateMillis[i]),
        _pixelCalculator.getPixelY(avgSpeeds[i]),
      );
    }

    canvas.drawPath(path, _avgSpeedLinePaint);
  }

// void _drawDots(Canvas canvas) {
//   final circleRadius = 5.0;
//
//   final textStyle = TextStyle(
//     color: Colors.black,
//     fontSize: 15,
//   );
//
//   for (int i = 0; i < temps.size; i++) {
//     final double x = pixelCalculator.getPixelX(dateMillis[i]);
//     final double y = pixelCalculator.getPixelY(temps[i]);
//
//     canvas.drawCircle(Offset(x, y), circleRadius, _dotBorderPaint);
//     canvas.drawCircle(Offset(x, y), circleRadius - 1, _dotFillPaint);
//
//     final textSpan = TextSpan(
//       text: '${temps[i]}°',
//       style: textStyle,
//     );
//
//     final textPainter = TextPainter(
//       text: textSpan,
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.center,
//     )..layout();
//
//     final offset = Offset(x - textPainter.width / 2, y - 25);
//     textPainter.paint(canvas, offset);
//   }
// }
}
