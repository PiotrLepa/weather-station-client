import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_left_titles.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/weather_chart_content.dart';

class WeatherChart extends StatelessWidget {
  final KtList<Weather> weathers;

  const WeatherChart({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ScrollConfiguration(
        behavior: DisableOverscrollGlowBehavior(),
        child: SizedBox(
          height: ChartConstants.heights.sum(),
          child: CustomScrollView(
            scrollDirection: Axis.horizontal,
            slivers: [
              SliverPersistentHeader(
                floating: true,
                delegate: HourlyWeatherLeftTitles(
                  leftTitles: ChartConstants.leftTitles
                      .map((title) => context.translate(title)),
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
