import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/chart_title.dart';

class NormalChartTitle extends ChartTitle {
  static final _threeDots = '\u2026';

  final _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _bottomDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = ChartConstants.dividerColor
    ..strokeWidth = ChartConstants.horizontalDividerWidth;

  final _verticalDividerWidth = 8.0;

  final String title;
  final double itemHeight;
  final double previousHeights;

  NormalChartTitle(this.title, this.itemHeight, this.previousHeights);

  @override
  Offset draw(Canvas canvas, Size size) {
    _drawBottomDivider(canvas, size);
    _drawRightShadow(canvas, size);
    return _drawTitle(canvas, size);
  }

  Offset _drawTitle(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text: title,
      style: _titleStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      ellipsis: _threeDots,
    )..layout(maxWidth: size.width - 20);

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (itemHeight - textPainter.height) / 2 + previousHeights,
    );
    textPainter.paint(canvas, textOffset);

    return Offset(
      textOffset.dx,
      itemHeight / 2 + previousHeights + textPainter.height,
    );
  }

  void _drawBottomDivider(Canvas canvas, Size size) {
    final y = itemHeight + previousHeights;
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      _bottomDividerPaint,
    );
  }

  void _drawRightShadow(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      size.width - _verticalDividerWidth,
      previousHeights,
      size.width,
      size.height + previousHeights,
    );
    final colors = [
      ChartConstants.dividerColor.withOpacity(0),
      ChartConstants.dividerColor.withOpacity(0.3),
      ChartConstants.dividerColor,
    ];

    final verticalDividerPaint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect);

    canvas.drawRect(rect, verticalDividerPaint);
  }
}
