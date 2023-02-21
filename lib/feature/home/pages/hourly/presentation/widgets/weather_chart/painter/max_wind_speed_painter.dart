import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_pixel_utils.dart';

class MaxWindSpeedPainter extends CustomPainter {
  static const moderateMinWindSpeed = 15.0;
  static const strongMinWindSpeed = 20.0;
  static const _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );
  static final _containerPaint = Paint()
    ..color = Colors.grey.shade300
    ..style = PaintingStyle.fill;

  final _pixelCalculator = ChartPixelCalculator<double>();

  final List<double> speedSpots;
  final List<int> timeSpots;
  final String strongWindText;
  final String moderateWindText;
  final String weakWindText;

  MaxWindSpeedPainter({
    required this.speedSpots,
    required this.timeSpots,
    required this.strongWindText,
    required this.moderateWindText,
    required this.weakWindText,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _pixelCalculator.initialize(
      size,
      minY: speedSpots.reduce(min),
      maxY: speedSpots.reduce(max),
    );
    _drawContainer(canvas, size);
    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = oldDelegate as MaxWindSpeedPainter;
    return oldPainter.speedSpots != speedSpots ||
        oldPainter.timeSpots != timeSpots;
  }

  void _drawContainer(Canvas canvas, Size size) {
    final path = Path();

    final barWidth =
        _pixelCalculator.getPixelX(1) - _pixelCalculator.getPixelX(0);
    final halfBarWidth = barWidth / 2;

    for (var i = 0; i < speedSpots.length; i++) {
      final x = _pixelCalculator.getPixelX(i);

      path.addRect(
        Rect.fromLTRB(
          x - halfBarWidth,
          0,
          x + halfBarWidth,
          size.height,
        ),
      );
    }

    canvas.drawPath(path, _containerPaint);
  }

  void _drawText(Canvas canvas, Size size) {
    for (var i = 0; i < speedSpots.length; i++) {
      final x = _pixelCalculator.getPixelX(i);

      final textSpan = TextSpan(
        text: _getWindPowerText(speedSpots[i]),
        style: _textStyle,
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout();

      final offset = Offset(
        x - textPainter.width / 2,
        (size.height - textPainter.height) / 2,
      );
      textPainter.paint(canvas, offset);
    }
  }

  String _getWindPowerText(double speed) {
    if (speed > moderateMinWindSpeed) {
      return moderateWindText;
    } else if (speed > strongMinWindSpeed) {
      return strongWindText;
    } else {
      return weakWindText;
    }
  }
}
