import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';

class LeftTitlesPainter extends CustomPainter {
  final _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _legendStyle = TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  final _horizontalDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = ChartConstants.dividerColor
    ..strokeWidth = ChartConstants.horizontalDividerWidth;

  final _pm1Paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.deepPurple[200]
    ..style = PaintingStyle.fill;

  final _verticalDividerWidth = 8.0;

  final _threeDots = '\u2026';

  final KtList<double> itemsHeights;
  final KtList<String> titles;

  LeftTitlesPainter({
    @required this.itemsHeights,
    @required this.titles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double previousHeights = 0;

    for (int i = 0; i < itemsHeights.size; i++) {
      final containerHeight = itemsHeights[i];
      final title = titles[i];

      final titleContainer = Size(
        size.width - _verticalDividerWidth,
        size.height,
      );
      _drawText(
        canvas,
        titleContainer,
        title,
        containerHeight,
        previousHeights,
        i == 5,
      );

      _drawHorizontalDivider(
        canvas,
        titleContainer,
        containerHeight,
        previousHeights,
      );

      previousHeights += containerHeight;
    }

    _drawRightShadow(canvas, size);
  }

  @override
  bool shouldRepaint(LeftTitlesPainter oldDelegate) {
    return oldDelegate.titles != titles &&
        oldDelegate.itemsHeights != itemsHeights;
  }

  void _drawText(
    Canvas canvas,
    Size size,
    String title,
    double containerHeight,
    double previousHeights,
    bool drawLegend,
  ) {
    final textSpan = TextSpan(
      text: title,
      style: _titleStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      ellipsis: _threeDots,
    )
      ..layout(maxWidth: size.width);

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (containerHeight - textPainter.height) / 2 + previousHeights,
    );
    textPainter.paint(canvas, textOffset);

    if (drawLegend) {
      final topOffSet = Offset(
        textOffset.dx,
        textOffset.dy + textPainter.height,
      );
      _drawAirPollutionLegend(canvas, size, topOffSet);
    }
  }

  void _drawAirPollutionLegend(Canvas canvas, Size size, Offset topOffset) {
    final spaceHeight = 5.0;
    final squareSize = 15.0;
    _drawLegend(
      canvas,
      size,
      squareSize,
      topOffset.dx,
      topOffset.dy + spaceHeight,
      _pm1Paint,
      'Pm 1',
    );
    _drawLegend(
      canvas,
      size,
      squareSize,
      topOffset.dx,
      topOffset.dy + squareSize + spaceHeight * 2,
      _pm1Paint,
      'Pm 2.5',
    );
    _drawLegend(
      canvas,
      size,
      squareSize,
      topOffset.dx,
      topOffset.dy + squareSize * 2 + spaceHeight * 3,
      _pm1Paint,
      'Pm 10',
    );
  }

  void _drawLegend(Canvas canvas,
      Size size,
      double squareSize,
      double leftOffSet,
      double topOffSet,
      Paint paint,
      String text,) {
    canvas.drawRect(
      Rect.fromLTWH(
        leftOffSet,
        topOffSet,
        squareSize,
        squareSize,
      ),
      paint,
    );

    final textSpan = TextSpan(
      text: text,
      style: _legendStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      ellipsis: _threeDots,
    )
      ..layout(maxWidth: size.width);

    final textOffset = Offset(
      leftOffSet + squareSize + 5,
      topOffSet + 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  void _drawHorizontalDivider(Canvas canvas,
      Size size,
      double containerHeight,
      double previousHeights,) {
    canvas.drawLine(
      Offset(
        0,
        containerHeight + previousHeights - _horizontalDividerPaint.strokeWidth,
      ),
      Offset(
        size.width,
        containerHeight + previousHeights - _horizontalDividerPaint.strokeWidth,
      ),
      _horizontalDividerPaint,
    );
  }

  void _drawRightShadow(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      size.width - _verticalDividerWidth,
      0,
      size.width,
      size.height,
    );
    final colors = [
      ChartConstants.dividerColor.withOpacity(0),
      ChartConstants.dividerColor,
    ];

    final verticalDividerPaint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect);

    canvas.drawRect(rect, verticalDividerPaint);
  }
}
