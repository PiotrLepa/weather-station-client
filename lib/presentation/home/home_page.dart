import 'package:flutter/material.dart';
import 'package:weather_station/presentation/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/presentation/fill_empty_space_sliver.dart';
import 'package:weather_station/presentation/home/widgets/home_app_bar.dart';
import 'package:weather_station/presentation/home/widgets/home_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBarHeight = kToolbarHeight;
    final appBarExpandedHeight = 250.0;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: DisableOverscrollGlowBehavior(),
        child: CustomScrollView(
          slivers: [
            HomeAppBar(
              height: appBarHeight,
              expandedHeight: appBarExpandedHeight,
            ),
            // HomeAppBarCorners(),
            HomeCards(),
            FillEmptySpaceSliver(
              minHeaderHeight: appBarHeight,
              maxHeaderHeight: appBarExpandedHeight,
            ),
          ],
        ),
      ),
    );
  }
}
