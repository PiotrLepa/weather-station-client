import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_pixel_utils.dart';

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

  final List<int> pm1Spots;
  final List<int> pm25Spots;
  final List<int> pm10Spots;
  final List<int> timeSpots;

  AirPollutionPainter({
    required this.pm1Spots,
    required this.pm25Spots,
    required this.pm10Spots,
    required this.timeSpots,
  });

  @override
  void paint(Canvas canvas, Size size) {
    List<int> summedValues = [];
    for (var i = 0; i < pm1Spots.length; i++) {
      summedValues.add(pm1Spots[i] + pm25Spots[i] + pm10Spots[i]);
    }

    _pixelCalculator.initialize(
      size,
      minY: 0,
      maxY: summedValues.reduce(max),
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

    for (var i = 0; i < pm1Spots.length; i++) {
      final x = _pixelCalculator.getPixelX(i);
      final pm1Pixel = _pixelCalculator.getPixelY(pm1Spots[i]);
      final pm25Pixel = _pixelCalculator.getPixelY(pm25Spots[i]);
      final pm10Pixel = _pixelCalculator.getPixelY(pm10Spots[i]);
      final barLeftPixel = x - halfBarWidth;
      final barRightPixel = x + halfBarWidth;

      // bottom bar
      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm10Pixel,
        right: barRightPixel,
        bottom: size.height,
        x: x,
        value: pm10Spots[i],
        paint: _pm10BarPaint,
      );

      final pm10BarHeight = size.height - pm10Pixel;
      // middle bar
      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm25Pixel - pm10BarHeight,
        right: barRightPixel,
        bottom: pm10Pixel,
        x: x,
        value: pm25Spots[i],
        paint: _pm25BarPaint,
      );

      final pm25BarHeight = size.height - pm25Pixel;
      // top bar
      _drawBarWithValue(
        canvas: canvas,
        left: barLeftPixel,
        top: pm1Pixel - pm10BarHeight - pm25BarHeight,
        right: barRightPixel,
        bottom: pm25Pixel - pm10BarHeight,
        x: x,
        value: pm1Spots[i],
        paint: _pm1BarPaint,
      );
    }
  }

  void _drawBarWithValue({
    required Canvas canvas,
    required double left,
    required double top,
    required double right,
    required double bottom,
    required double x,
    required int value,
    required Paint paint,
  }) {
    final bar = Rect.fromLTRB(
      left,
      top,
      right,
      bottom,
    );
    canvas.drawRect(bar, paint);
    _drawSpotValue(canvas, value, bar.height, x, top + bottom);
  }

  void _drawSpotValue(
    Canvas canvas,
    int value,
    double barHeight,
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

    if (barHeight >= textPainter.height) {
      textPainter.paint(canvas, textOffset);
    }
  }
}
