import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

class LeftTitlesPainter extends CustomPainter {
  final _titleStyle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final _dividerPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;

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

      _drawText(canvas, size, title, height, sum);
      _drawDivider(canvas, size, height, sum);

      sum += height;
    }
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

  void _drawDivider(
    Canvas canvas,
    Size size,
    double height,
    double sum,
  ) {
    canvas.drawLine(
      Offset(0, height + sum),
      Offset(size.width, height + sum),
      _dividerPaint,
    );
  }
}
