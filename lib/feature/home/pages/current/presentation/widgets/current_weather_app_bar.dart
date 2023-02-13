import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_update_time.dart';

class CurrentWeatherAppBar extends StatelessWidget {
  final double height;
  final double expandedHeight;
  final DateTime lastUpdateTime;
  final bool refreshLoading;

  const CurrentWeatherAppBar({
    Key? key,
    required this.height,
    required this.expandedHeight,
    required this.lastUpdateTime,
    required this.refreshLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: height,
      expandedHeight: expandedHeight,
      pinned: true,
      title: const Text("Pogoda"),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: height + MediaQuery.of(context).padding.top + 12,
            ),
            CurrentWeatherUpdateTime(
              lastUpdateTime: lastUpdateTime,
              refreshLoading: refreshLoading,
            ),
          ],
        ),
      ),
    );
  }
}
