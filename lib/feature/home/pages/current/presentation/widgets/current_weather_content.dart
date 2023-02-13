import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_app_bar.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_app_bar_corners.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_cards.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/disable_overscroll_glow_behavior.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/fill_empty_space_sliver.dart';

class CurrentWeatherContent extends StatelessWidget {
  final Weather weather;
  final bool refreshLoading;

  const CurrentWeatherContent({
    Key? key,
    required this.weather,
    required this.refreshLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appBarHeight = kToolbarHeight;
    const appBarExpandedHeight = 210.0;
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          CurrentWeatherAppBar(
            height: appBarHeight,
            expandedHeight: appBarExpandedHeight,
            lastUpdateTime: weather.timestamp,
            refreshLoading: refreshLoading,
          ),
          const CurrentWeatherAppBarCorners(),
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
