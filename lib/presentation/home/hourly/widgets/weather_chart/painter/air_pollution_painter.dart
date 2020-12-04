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
    ..color = airPollutionPm1Color
    ..style = PaintingStyle.fill;

  static final _pm25BarPaint = Paint()
    ..color = airPollutionPm25Color
    ..style = PaintingStyle.fill;

  static final _pm10BarPaint = Paint()
    ..color = airPollutionPm10Color
    ..style = PaintingStyle.fill;

  final _pixelCalculator = ChartPixelCalculator<int>();

  final KtList<int> pm1Spots;
  final KtList<int> pm25Spots;
  final KtList<int> pm10Spots;
  final KtList<int> timeSpots;

  AirPollutionPainter({
    @required this.pm1Spots,
    @required this.pm25Spots,
    @required this.pm10Spots,
    @required this.timeSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final summedValues = KtMutableList<int>.empty();
    for (var i = 0; i < pm1Spots.size; i++) {
      summedValues.add(pm1Spots[i] + pm25Spots[i] + pm10Spots[i]);
    }

    _pixelCalculator.initialize(
      size,
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
    final barWidth =
        _pixelCalculator.getPixelX(1) - _pixelCalculator.getPixelX(0);
    final halfBarWidth = barWidth / 2;

    for (var i = 0; i < pm1Spots.size; i++) {
      final x = _pixelCalculator.getPixelX(i);
      final pm1Pixel = _pixelCalculator.getPixelY(pm1Spots[i]);
      final pm25Pixel = _pixelCalculator.getPixelY(pm25Spots[i]);
      final pm10Pixel = _pixelCalculator.getPixelY(pm10Spots[i]);
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
    @required int value,
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
    int value,
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
