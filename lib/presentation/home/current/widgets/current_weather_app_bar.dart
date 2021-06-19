import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_location.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_update_time.dart';

class CurrentWeatherAppBar extends StatelessWidget {
  final double height;
  final double expandedHeight;
  final DateTime lastUpdateTime;
  final bool refreshLoading;
  final String? address;

  const CurrentWeatherAppBar({
    Key? key,
    required this.height,
    required this.expandedHeight,
    required this.lastUpdateTime,
    required this.refreshLoading,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: height,
      expandedHeight: expandedHeight,
      pinned: true,
      title: Text(Strings.weatherPageAppBarTitle.get(context)),
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            SizedBox(
              height: height + MediaQuery.of(context).padding.top + 12,
            ),
            ..._getAddressWidget(),
            CurrentWeatherUpdateTime(
              lastUpdateTime: lastUpdateTime,
              refreshLoading: refreshLoading,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getAddressWidget() {
    if (address != null) {
      return [
        HomeLocation(location: address!),
        const SizedBox(height: 20),
      ];
    } else {
      return [];
    }
  }
}
