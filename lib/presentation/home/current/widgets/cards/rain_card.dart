import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/current/widgets/weather_value.dart';

class RainCard extends StatelessWidget {
  final double rainGauge;

  const RainCard({
    Key key,
    @required this.rainGauge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff27C4FF),
      iconPath: 'assets/icons/rain.svg',
      title: 'Opady',
      body: WeatherValue(
        value: rainGauge.toString(),
        unit: 'mm/cm\u00B2',
      ),
    );
  }
}
