import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/common/fill_empty_space_sliver.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar_corners.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_cards.dart';

class CurrentWeatherContent extends StatelessWidget {
  final Weather weather;
  final bool refreshLoading;

  const CurrentWeatherContent({
    Key key,
    @required this.weather,
    @required this.refreshLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appBarHeight = kToolbarHeight;
    const appBarExpandedHeight = 300.0;
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: CustomScrollView(
        slivers: [
          CurrentWeatherAppBar(
            height: appBarHeight,
            expandedHeight: appBarExpandedHeight,
            location: weather.location,
            lastUpdateTime: weather.date,
            refreshLoading: refreshLoading,
          ),
          CurrentWeatherAppBarCorners(),
          CurrentWeatherCards(weather: weather),
          const FillEmptySpaceSliver(
            minHeaderHeight: appBarHeight,
            maxHeaderHeight: appBarExpandedHeight,
          ),
        ],
      ),
    );
  }
}
