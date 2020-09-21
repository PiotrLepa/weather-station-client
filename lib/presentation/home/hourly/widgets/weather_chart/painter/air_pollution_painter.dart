import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_pixel_utils.dart';

class AirPollutionPainter extends CustomPainter {
  static const _spotValueStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  static final _pm1BarPaint = Paint()
    ..color = ChartConstants.airPollutionPm1Color
    ..style = PaintingStyle.fill;

  static final _pm25BarPaint = Paint()
    ..color = ChartConstants.airPollutionPm25Color
    ..style = PaintingStyle.fill;

  static final _pm10BarPaint = Paint()
    ..color = ChartConstants.airPollutionPm10Color
    ..style = PaintingStyle.fill;

  final pixelCalculator = ChartPixelCalculator<int, double>();

  final KtList<double> pm1Spots;
  final KtList<double> pm25Spots;
  final KtList<double> pm10Spots;
  final KtList<int> timeSpots;

  AirPollutionPainter({
    @required this.pm1Spots,
    @required this.pm25Spots,
    @required this.pm10Spots,
    @required this.timeSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final summedValues = KtMutableList<double>.empty();
    for (int i = 0; i < pm1Spots.size; i++) {
      summedValues.add(pm1Spots[i] + pm25Spots[i] + pm10Spots[i]);
    }

    pixelCalculator.initialize(
      size,
      minX: timeSpots.min(),
      maxX: timeSpots.max(),
      minY: 0,
      maxY: summedValues.max(),
      topOffSet: 12,
    );
    _drawBars(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as AirPollutionPainter;
    return oldPainter.pm1Spots != pm1Spots ||
        oldPainter.pm25Spots != pm25Spots ||
        oldPainter.pm10Spots != pm10Spots ||
        oldPainter.timeSpots != timeSpots;
  }

  void _drawBars(Canvas canvas, Size size) {
    final barWidth = pixelCalculator.getPixelX(timeSpots[1]) -
        pixelCalculator.getPixelX(timeSpots[0]);
    final halfBarWidth = barWidth / 2;

    for (int i = 0; i < pm1Spots.size; i++) {
      final x = pixelCalculator.getPixelX(timeSpots[i]);
      final pm1Pixel = pixelCalculator.getPixelY(pm1Spots[i]);
      final pm25Pixel = pixelCalculator.getPixelY(pm25Spots[i]);
      final pm10Pixel = pixelCalculator.getPixelY(pm10Spots[i]);
      final barLeftPixel = x - halfBarWidth;
      final barRightPixel = x + halfBarWidth;

      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm1Pixel,
        right: barRightPixel,
        bottom: size.height,
        x: x,
        value: pm1Spots[i],
        paint: _pm1BarPaint,
      );

      final pm1BarHeight = size.height - pm1Pixel;
      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm25Pixel - pm1BarHeight,
        right: barRightPixel,
        bottom: pm1Pixel,
        x: x,
        value: pm25Spots[i],
        paint: _pm25BarPaint,
      );

      final pm25BarHeight = size.height - pm25Pixel + pm1BarHeight;
      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm10Pixel - pm25BarHeight,
        right: barRightPixel,
        bottom: pm25Pixel - pm1BarHeight,
        x: x,
        value: pm10Spots[i],
        paint: _pm10BarPaint,
      );
    }
  }

  void _drawBarWithValue({
    @required Canvas canvas,
    @required double left,
    @required double top,
    @required double right,
    @required double bottom,
    @required double x,
    @required double value,
    @required Paint paint,
  }) {
    canvas.drawRect(
      Rect.fromLTRB(
        left,
        top,
        right,
        bottom,
      ),
      paint,
    );
    _drawSpotValue(canvas, value, x, top + bottom);
  }

  void _drawSpotValue(
    Canvas canvas,
    double value,
    double x,
    double y,
  ) {
    final textSpan = TextSpan(
      text: value.toString(),
      style: _spotValueStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final textOffset = Offset(
      x - textPainter.width / 2,
      (y - textPainter.height) / 2,
    );
    textPainter.paint(canvas, textOffset);
  }
}
