import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class AirPollutionPainter extends CustomPainter {
  final pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> pm1Spots;
  final KtList<double> pm25Spots;
  final KtList<double> pm10Spots;
  final KtList<int> dateMillis;

  final _pm1BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.deepPurple[200]
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  final _pm25BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.red[200]
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  final _pm10BarPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.green[200]
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  final _linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  AirPollutionPainter({
    @required this.pm1Spots,
    @required this.pm25Spots,
    @required this.pm10Spots,
    @required this.dateMillis,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final combinedYValues = [
      ...pm1Spots.asList(),
      ...pm25Spots.asList(),
      ...pm10Spots.asList(),
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
    _drawLines(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as AirPollutionPainter;
    return oldPainter.pm1Spots != pm1Spots ||
        oldPainter.pm25Spots != pm25Spots ||
        oldPainter.pm10Spots != pm10Spots ||
        oldPainter.dateMillis != dateMillis;
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

    for (int i = 0; i < pm1Spots.size; i++) {
      final x = pixelCalculator.getPixelX(dateMillis[i]);
      pm1Path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          pixelCalculator.getPixelY(pm1Spots[i]),
          x - halfColumnWidth,
          size.height,
        ),
      );
      pm25Path.addRect(
        Rect.fromLTRB(
          x - halfColumnWidth,
          pixelCalculator.getPixelY(pm25Spots[i]),
          x + halfColumnWidth,
          size.height,
        ),
      );
      pm10Path.addRect(
        Rect.fromLTRB(
          x + halfColumnWidth,
          pixelCalculator.getPixelY(pm10Spots[i]),
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(pm1Path, _pm1BarPaint);
    canvas.drawPath(pm25Path, _pm25BarPaint);
    canvas.drawPath(pm10Path, _pm10BarPaint);
  }

  void _drawLines(Canvas canvas, Size size) {
    final containerWidth = pixelCalculator.getPixelX(dateMillis[1]) -
        pixelCalculator.getPixelX(dateMillis[0]);
    final halfContainerWidth = containerWidth / 2;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );

    final avg = pm1Spots.average();

    for (int i = 0; i < pm1Spots.size; i++) {
      final x = pixelCalculator.getPixelX(dateMillis[i]);
      final max = KtList.of(pm1Spots[i], pm25Spots[i], pm10Spots[i]).max();
      final yMax = pixelCalculator.getPixelY(avg);

      canvas.drawLine(
        Offset(x - halfContainerWidth, yMax),
        Offset(x + halfContainerWidth, yMax),
        _linePaint,
      );

      //   final textSpanMax = TextSpan(
      //     text: '$max',
      //     style: textStyle,
      //   );
      //
      //   final textPainterMax = TextPainter(
      //     text: textSpanMax,
      //     textDirection: TextDirection.ltr,
      //     textAlign: TextAlign.center,
      //   )..layout();
      //
      //   final offsetMax = Offset(x - textPainterMax.width / 2, yMax - 20);
      //   textPainterMax.paint(canvas, offsetMax);
      //
      //
      //
      //   final min = KtList.of(pm1Spots[i], pm25Spots[i], pm10Spots[i]).min();
      //   final yMin = pixelCalculator.getPixelY(min);
      //
      //   canvas.drawLine(
      //     Offset(x - halfContainerWidth, yMin),
      //     Offset(x + halfContainerWidth, yMin),
      //     _linePaint,
      //   );
      //
      //   final textSpanMin = TextSpan(
      //     text: '$min',
      //     style: textStyle,
      //   );
      //
      //   final textPainterMin = TextPainter(
      //     text: textSpanMin,
      //     textDirection: TextDirection.ltr,
      //     textAlign: TextAlign.center,
      //   )..layout();
      //
      //   final offsetMin = Offset(x - textPainterMin.width / 2, yMin + 5);
      //   textPainterMin.paint(canvas, offsetMin);
    }
  }
}
