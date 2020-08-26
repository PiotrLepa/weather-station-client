import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';

class HumidityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff67e4dc),
      iconPath: 'assets/icons/humidity.svg',
      title: 'Wilgotność',
      body: Text(
        '54.6 %',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
