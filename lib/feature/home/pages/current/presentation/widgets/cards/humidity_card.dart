import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/gen/assets.gen.dart';

class HumidityCard extends StatelessWidget {
  final double humidity;

  const HumidityCard({
    Key? key,
    required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff67e4dc),
      iconPath: Assets.icons.humidity.path,
      title: "Wilgotność",
      body: Text(
        '$humidity %',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
