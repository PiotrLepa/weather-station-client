import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/normal_chart_title.dart';

class LegendChartTitle extends NormalChartTitle {
  static final _threeDots = '\u2026';

  static final _legendStyle = TextStyle(
    color: Colors.black,
    fontSize: 11,
    fontWeight: FontWeight.w500,
  );

  final _paint = Paint()
    ..style = PaintingStyle.stroke
    ..style = PaintingStyle.fill;

  final String title;
  final double itemHeight;
  final double previousHeights;
  final KtList<ChartLegend> legends;

  LegendChartTitle(
    this.title,
    this.itemHeight,
    this.previousHeights,
    this.legends,
  ) : super(title, itemHeight, previousHeights);

  @override
  Offset draw(Canvas canvas, Size size) {
    final titleOffSet = super.draw(canvas, size);
    final squareSize = 15.0;
    final spaceHeight = 5.0;

    legends.forEachIndexed((index, legend) {
      final offSet = Offset(
        titleOffSet.dx,
        titleOffSet.dy + (squareSize + spaceHeight) * index,
      );
      _drawLegend(canvas, size, squareSize, offSet, legend);
    });

    return titleOffSet;
  }

  void _drawLegend(
    Canvas canvas,
    Size size,
    double squareSize,
    Offset titleOffset,
    ChartLegend legend,
  ) {
    canvas.drawRect(
      Rect.fromLTWH(
        titleOffset.dx,
        titleOffset.dy,
        squareSize,
        squareSize,
      ),
      _paint..color = legend.color,
    );

    final textSpan = TextSpan(
      text: legend.text,
      style: _legendStyle,
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      ellipsis: _threeDots,
    )..layout(maxWidth: size.width / 3 + 5);

    final textOffset = Offset(
      titleOffset.dx + squareSize + 5,
      titleOffset.dy + 2.0,
    );
    textPainter.paint(canvas, textOffset);
  }
}

class ChartLegend {
  final String text;
  final Color color;

  ChartLegend(
    this.text,
    this.color,
  );
}
