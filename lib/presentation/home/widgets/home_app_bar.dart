import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/presentation/home/widgets/cards/home_location.dart';
import 'package:weather_station/presentation/home/widgets/cards/home_refresh_time.dart';

class HomeAppBar extends StatelessWidget {
  final double height;

  final double expandedHeight;

  const HomeAppBar({
    Key key,
    @required this.height,
    @required this.expandedHeight,
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
              height: height + MediaQuery
                  .of(context)
                  .padding
                  .top + 12,
            ),
            HomeLocation(),
            SizedBox(height: 20),
            HomeRefreshTime(),
          ],
        ),
      ),
    );
  }
}
