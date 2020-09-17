import 'package:flutter/cupertino.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

abstract class ChartTitle {
  final RKString title;
  final double height;

  ChartTitle(this.title, this.height);

  Offset draw(
    BuildContext context,
    Canvas canvas,
    Size size,
    double previousHeights,
  );
}
