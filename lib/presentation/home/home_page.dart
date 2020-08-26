import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/home_grid.dart';
import 'package:weather_station/presentation/home/widgets/home_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          HomeGrid(),
          HomeList(),
        ],
      ),
    );
  }
}
