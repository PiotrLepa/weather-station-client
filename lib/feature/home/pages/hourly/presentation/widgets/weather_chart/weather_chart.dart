import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/disable_overscroll_glow_behavior.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/hourly_weather_left_titles.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/left_titles/left_titles_provider.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/weather_chart_content.dart';

class WeatherChart extends StatelessWidget {
  final List<Weather> weathers;

  const WeatherChart({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftTitles = LeftTitlesProvider.getTitles(context);
    return Card(
      elevation: 4,
      child: ScrollConfiguration(
        behavior: DisableOverscrollGlowBehavior(),
        child: Container(
          height: heights.reduce((sum, value) => sum + value),
          color: backgroundColor,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
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
                  [
                    WeatherChartContent(weathers: weathers),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
