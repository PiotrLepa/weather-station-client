import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';

class NormalChartTitle extends ChartTitle {
  static const _threeDots = '\u2026';

  final _titleStyle = const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _bottomDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = dividerColor
    ..strokeWidth = horizontalDividerWidth;

  final _verticalDividerWidth = 8.0;

  NormalChartTitle(
    String title,
    double itemHeight,
  ) : super(title, itemHeight);

  @override
  Offset draw(
    BuildContext context,
    Canvas canvas,
    Size size,
    double previousHeights,
  ) {
    _drawBottomDivider(canvas, size, previousHeights);
    _drawRightShadow(canvas, size, previousHeights);
    return _drawTitle(context, canvas, size, previousHeights);
  }

  Offset _drawTitle(
    BuildContext context,
    Canvas canvas,
    Size size,
    double previousHeights,
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

  void _drawBottomDivider(Canvas canvas, Size size, double previousHeights) {
    final y = itemHeight + previousHeights;
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      _bottomDividerPaint,
    );
  }

  void _drawRightShadow(Canvas canvas, Size size, double previousHeights) {
    final rect = Rect.fromLTRB(
      size.width - _verticalDividerWidth,
      previousHeights,
      size.width,
      itemHeight + previousHeights,
    );
    final colors = [
      dividerColor.withOpacity(0),
      dividerColor,
    ];

    final verticalDividerPaint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect);

    canvas.drawRect(rect, verticalDividerPaint);
  }
}
