import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/air_pollution_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/humidity_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/pressure_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/rain_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/temperature_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/wind_card.dart';

class HomeCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              children: [
                Expanded(child: TemperatureCard()),
                Expanded(child: HumidityCard()),
              ],
            ),
            Row(
              children: [
                Expanded(child: RainCard()),
                Expanded(child: PressureCard()),
              ],
            ),
            AirPollutionCard(),
            WindCard(),
          ],
        ),
      ),
    );
  }
}
