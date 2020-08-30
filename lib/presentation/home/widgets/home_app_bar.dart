import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/presentation/home/widgets/home_location.dart';
import 'package:weather_station/presentation/home/widgets/home_update_time.dart';

class HomeAppBar extends StatelessWidget {
  final double height;
  final double expandedHeight;
  final String location;
  final DateTime lastUpdateTime;

  const HomeAppBar({
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
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: ThemeProvider.of(context).textColorInverted,
          ),
          onPressed: () {},
        )
      ],
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
