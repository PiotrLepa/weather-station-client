import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/air_pollution_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/wind_card.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            AirPollutionCard(),
            WindCard(),
          ],
        ),
      ),
    );
  }
}
