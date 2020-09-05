import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class LeftTitlesPainter extends CustomPainter {
  final _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _horizontalDividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

  final _verticalDividerWidth = 8.0;

  final KtList<double> itemsHeights;
  final KtList<String> titles;

  LeftTitlesPainter({
    @required this.itemsHeights,
    @required this.titles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double sum = 0;

    for (int i = 0; i < itemsHeights.size; i++) {
      final height = itemsHeights[i];
      final title = titles[i];

      final titleContainer = Size(
        size.width - _verticalDividerWidth,
        size.height,
      );
      _drawText(canvas, titleContainer, title, height, sum);
      _drawHorizontalDivider(canvas, titleContainer, height, sum);

      sum += height;
    }

    _drawVerticalDivider(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawText(
    Canvas canvas,
    Size size,
    String title,
    double height,
    double sum,
  ) {
    final textSpan = TextSpan(
      text: title,
      style: _titleStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout();

    final textOffset = Offset(
      (size.width - textPainter.width) / 2,
      (height - textPainter.height) / 2 + sum,
    );
    textPainter.paint(canvas, textOffset);
  }

  void _drawHorizontalDivider(
    Canvas canvas,
    Size size,
    double height,
    double sum,
  ) {
    canvas.drawLine(
      Offset(0, height + sum - _horizontalDividerPaint.strokeWidth),
      Offset(size.width, height + sum - _horizontalDividerPaint.strokeWidth),
      _horizontalDividerPaint,
    );
  }

  void _drawVerticalDivider(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(
      size.width - _verticalDividerWidth,
      0,
      size.width,
      size.height,
    );
    final colors = [
      Colors.grey.withOpacity(0.4),
      Colors.grey.withOpacity(0.05),
    ];

    final verticalDividerPaint = Paint()
      ..shader = LinearGradient(colors: colors).createShader(rect);

    canvas.drawRect(rect, verticalDividerPaint);
  }
}
