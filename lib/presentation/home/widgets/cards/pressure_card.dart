import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/widgets/weather_value.dart';

class PressureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff00347b),
      iconPath: 'assets/icons/pressure.svg',
      title: 'Ciśnienie',
      body: WeatherValue(
        value: '1007',
        unit: 'hpa',
      ),
    );
  }
}
