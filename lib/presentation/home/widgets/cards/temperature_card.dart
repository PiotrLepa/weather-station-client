import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';

class TemperatureCard extends StatelessWidget {
  final double temperature;

  const TemperatureCard({
    Key key,
    @required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xfff0c419),
      iconPath: 'assets/icons/temp.svg',
      title: 'Temperatura',
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Text(
            '$temperature °C',
            style: TextStyle(
              fontSize: Dimens.scale(20),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.arrow_upward,
            color: Color(0xfff0c419),
            size: Dimens.scale(16),
          ),
        ],
      ),
    );
  }
}
