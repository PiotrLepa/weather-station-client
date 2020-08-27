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
      padding: EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              children: [
                Expanded(child: TemperatureCard()),
                SizedBox(width: 4),
                Expanded(child: HumidityCard()),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(child: RainCard()),
                SizedBox(width: 4),
                Expanded(child: PressureCard()),
              ],
            ),
            SizedBox(height: 4),
            AirPollutionCard(),
            SizedBox(height: 4),
            WindCard(),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
