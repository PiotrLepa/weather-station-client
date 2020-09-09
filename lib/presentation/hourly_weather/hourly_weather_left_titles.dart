import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';

import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/left_titles_painter.dart';

class HourlyWeatherLeftTitles extends SliverPersistentHeaderDelegate {
  final KtList<String> leftTitles;

  final double _leftTitlesWidth;

  HourlyWeatherLeftTitles({@required this.leftTitles})
      : _leftTitlesWidth = leftTitles[1].length * 10.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: ThemeProvider.of(context).backgroundColor,
      child: CustomPaint(
        size: Size(
          _leftTitlesWidth,
          ChartConstants.heights.sum(),
        ),
        painter: LeftTitlesPainter(
          itemsHeights: ChartConstants.heights,
          titles: leftTitles,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(HourlyWeatherLeftTitles oldDelegate) => false;

  @override
  double get maxExtent => _leftTitlesWidth;

  @override
  double get minExtent => 50;
}
