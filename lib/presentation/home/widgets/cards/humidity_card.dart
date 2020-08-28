import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';

class HumidityCard extends StatelessWidget {
  final double humidity;

  const HumidityCard({
    Key key,
    @required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff67e4dc),
      iconPath: 'assets/icons/humidity.svg',
      title: 'Wilgotność',
      body: Text(
        '$humidity %',
        style: TextStyle(
          fontSize: Dimens.scale(20),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
