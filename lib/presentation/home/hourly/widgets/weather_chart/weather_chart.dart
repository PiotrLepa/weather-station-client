import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_left_titles.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/left_titles_provider.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/weather_chart_content.dart';

class WeatherChart extends StatelessWidget {
  final KtList<Weather> weathers;

  const WeatherChart({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftTitles = LeftTitlesProvider.getTitles(context);
    return Card(
      elevation: 4,
      child: ScrollConfiguration(
        behavior: DisableOverscrollGlowBehavior(),
        child: Container(
          height: ChartConstants.heights.sum(),
          color: ChartConstants.backgroundColor,
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: HourlyWeatherLeftTitles(
                  titles: leftTitles,
                  maxWidth: leftTitles[1].title.length * 10.0,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [WeatherChartContent(weathers: weathers)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
