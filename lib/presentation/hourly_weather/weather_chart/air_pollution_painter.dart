import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_pixel_utils.dart';

class AirPollutionPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> pm1;
  final KtList<double> pm25;
  final KtList<double> pm10;
  final KtList<int> dateMillis;

  final _pm1BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blue
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  final _pm25BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.blueGrey
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  final _pm10BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.lightBlue
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  AirPollutionPainter({
    @required this.pm1,
    @required this.pm25,
    @required this.pm10,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final combinedYValues = [
      ...pm1.asList(),
      ...pm25.asList(),
      ...pm10.asList(),
    ].toImmutableList();

    pixelCalculator.initialize(
      size,
      minX: dateMillis.min(),
      maxX: dateMillis.max(),
      minY: combinedYValues.min(),
      maxY: combinedYValues.max(),
      topOffSet: 24,
    );
    _drawBars(canvas, size);
    // _drawValues(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawBars(Canvas canvas, Size size) {
    final Path pm1Path = Path();
    final Path pm25Path = Path();
    final Path pm10Path = Path();

    final barWidth = pixelCalculator.getPixelX(dateMillis[1]) -
        pixelCalculator.getPixelX(dateMillis[0]);
    final halfBarWidth = barWidth / 2;
    final columnWidth = barWidth / 3;
    final halfColumnWidth = columnWidth / 2;

    for (int i = 0; i < pm1.size; i++) {
      final x = pixelCalculator.getPixelX(dateMillis[i]);
      pm1Path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          pixelCalculator.getPixelY(pm1[i]),
          x - halfColumnWidth,
          size.height,
        ),
      );
      pm25Path.addRect(
        Rect.fromLTRB(
          x - halfColumnWidth,
          pixelCalculator.getPixelY(pm25[i]),
          x + halfColumnWidth,
          size.height,
        ),
      );
      pm10Path.addRect(
        Rect.fromLTRB(
          x + halfColumnWidth,
          pixelCalculator.getPixelY(pm10[i]),
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(pm1Path, _pm1BarPaint);
    canvas.drawPath(pm25Path, _pm25BarPaint);
    canvas.drawPath(pm10Path, _pm10BarPaint);
  }

// void _drawValues(Canvas canvas) {
//   final textStyle = TextStyle(
//     color: Colors.black,
//     fontSize: 14,
//   );
//
//   for (int i = 0; i < rains.size; i++) {
//     final double x = pixelCalculator.getPixelX(dateMillis[i]);
//     final double y = pixelCalculator.getPixelY(rains[i]);
//
//     final textSpan = TextSpan(
//       text: '${rains[i]} mm',
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
