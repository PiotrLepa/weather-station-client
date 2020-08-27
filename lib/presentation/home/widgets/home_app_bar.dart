import 'package:flutter/material.dart';
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
        background: Container(
          color: Theme.of(context).appBarTheme.color,
          child: Image.asset(
            'assets/home_background4.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
