import 'package:flutter/cupertino.dart';

abstract class ChartTitle {
  final String title;
  final double height;

  ChartTitle(this.title, this.height);

  Offset draw(
    BuildContext context,
    Canvas canvas,
    Size size,
    double previousHeights,
  );
}
