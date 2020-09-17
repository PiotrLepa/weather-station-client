import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/left_titles_painter2.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/legend_chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_title/normal_chart_title.dart';

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
        painter: LeftTitlesPainter2(
          titles: _getChartTitles(),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(HourlyWeatherLeftTitles oldDelegate) {
    return oldDelegate.leftTitles != leftTitles;
  }

  KtList<ChartTitle> _getChartTitles() {
    double sum = 0;
    return leftTitles.mapIndexed((index, title) {
      final itemHeight = ChartConstants.heights[index];
      if (index == 5) {
        final chartTitle = LegendChartTitle(
          title,
          itemHeight,
          sum,
          KtList.of(
            ChartLegend('Pm 1', Colors.red),
            ChartLegend('Pm 25', Colors.grey),
            ChartLegend('Pm 10', Colors.blue),
          ),
        );
        sum += itemHeight;
        return chartTitle;
      }
      final chartTitle = NormalChartTitle(title, itemHeight, sum);
      sum += itemHeight;
      return chartTitle;
    });
  }

  @override
  double get maxExtent => _leftTitlesWidth;

  @override
  double get minExtent => 50;
}
