import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_location.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_update_time.dart';

class CurrentWeatherAppBar extends StatelessWidget {
  final double height;
  final double expandedHeight;
  final String location;
  final DateTime lastUpdateTime;

  const CurrentWeatherAppBar({
    Key key,
    @required this.height,
    @required this.expandedHeight,
    @required this.location,
    @required this.lastUpdateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: height,
      expandedHeight: expandedHeight,
      pinned: true,
      title: Text('Pogoda'),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: height + MediaQuery.of(context).padding.top + 12,
            ),
            HomeLocation(location: location),
            SizedBox(height: 20),
            HomeUpdateTime(lastUpdateTime: lastUpdateTime),
          ],
        ),
      ),
    );
  }
}
