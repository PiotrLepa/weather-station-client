import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_unit.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';

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
      title: context.strings.windSpeed,
      body: Column(
        children: [
          Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWindValue(
                      context.strings.windSpeedMax,
                      maxSpeed.toString(),
                    ),
                    const VerticalDivider(width: 50),
                    _buildWindValue(
                      context.strings.windSpeedAvg,
                      avgSpeed.toString(),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                bottom: 0,
                child: WeatherUnit(value: context.strings.windSpeedUnit),
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
