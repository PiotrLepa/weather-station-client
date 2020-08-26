import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/home_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(),
          HomeCards(),
        ],
      ),
    );
  }
}
