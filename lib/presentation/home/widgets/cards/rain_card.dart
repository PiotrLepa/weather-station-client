import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/widgets/weather_value.dart';

class RainCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff27C4FF),
      iconPath: 'assets/icons/rain.svg',
      title: 'Opady',
      body: WeatherValue(
        value: '44.2',
        unit: 'mm/cm\u00B2',
      ),
    );
  }
}
