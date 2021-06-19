import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/left_titles_painter.dart';

class HourlyWeatherLeftTitles extends SliverPersistentHeaderDelegate {
  final KtList<ChartTitle> titles;
  final double maxWidth;

  HourlyWeatherLeftTitles({
    required this.titles,
    required this.maxWidth,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: backgroundColor,
      child: CustomPaint(
        size: Size(
          maxWidth,
          heights.sum(),
        ),
        painter: LeftTitlesPainter(
          context: context,
          titles: titles,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(HourlyWeatherLeftTitles oldDelegate) {
    return oldDelegate.titles != titles;
  }

  @override
  double get maxExtent => maxWidth;

  @override
  double get minExtent => 50;
}
