import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/gen/assets.gen.dart';

class TemperatureCard extends StatelessWidget {
  final double temperature;

  const TemperatureCard({
    Key? key,
    required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xfff0c419),
      iconPath: Assets.icons.temp.path,
      title: "Temperatura",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            "$temperature °C",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
