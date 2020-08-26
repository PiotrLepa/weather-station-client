import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/humidity_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/pressure_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/rain_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/temperature_card.dart';

class HomeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final padding = 8.0;
    return SliverPadding(
      padding: EdgeInsets.all(padding),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.35,
          crossAxisSpacing: padding,
          mainAxisSpacing: padding,
          crossAxisCount: 2,
        ),
        delegate: SliverChildListDelegate(
          [
            TemperatureCard(),
            HumidityCard(),
            RainCard(),
            PressureCard(),
          ],
        ),
      ),
    );
  }
}
