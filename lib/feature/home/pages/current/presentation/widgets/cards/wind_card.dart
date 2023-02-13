import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_unit.dart';
import 'package:weather_station_client/gen/assets.gen.dart';

class WindCard extends StatelessWidget {
  final double maxSpeed;
  final double avgSpeed;

  const WindCard({
    Key? key,
    required this.maxSpeed,
    required this.avgSpeed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff869644),
      iconPath: Assets.icons.wind.path,
      title: "Prędkość wiatru",
      body: Column(
        children: [
          Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWindValue(
                      "Max",
                      maxSpeed.toString(),
                    ),
                    const VerticalDivider(width: 50),
                    _buildWindValue(
                      "Średnia",
                      avgSpeed.toString(),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 12,
                bottom: 0,
                child: WeatherUnit(value: "km/h"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWindValue(String name, String wind) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          wind,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
