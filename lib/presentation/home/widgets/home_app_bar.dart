import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';

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
        background: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stan Pogody",
                  style: TextStyle(
                    fontSize: Dimens.scale(20),
                    fontWeight: FontWeight.w800,
                    color: ThemeProvider.of(context).textColorInverted,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Dzisiaj, 12:40",
                  style: TextStyle(
                    fontSize: Dimens.scale(14),
                    fontWeight: FontWeight.w400,
                    color: ThemeProvider.of(context).textColorLightInverted,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.refresh,
              color: ThemeProvider.of(context).textColorInverted,
            ),
          ],
        ),
      ),
    );
  }
}
