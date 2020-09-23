import 'package:flutter/cupertino.dart';

abstract class ChartTitle {
  final String title;
  final double itemHeight;

  ChartTitle(this.title, this.itemHeight);

  Offset draw(
    BuildContext context,
    Canvas canvas,
    Size size,
    double previousHeights,
  );
}
