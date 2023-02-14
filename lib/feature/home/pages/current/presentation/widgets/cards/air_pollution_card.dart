import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_unit.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class AirPollutionCard extends StatelessWidget {
  final int pm1;
  final int pm25;
  final int pm10;

  const AirPollutionCard({
    Key? key,
    required this.pm1,
    required this.pm25,
    required this.pm10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff595959),
      iconPath: Assets.icons.airPollution.path,
      title: context.strings.airPollution,
      body: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPollutionValue(
                      context.strings.airPollutionPm1,
                      pm1.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      context.strings.airPollutionPm25,
                      pm25.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      context.strings.airPollutionPm10,
                      pm10.toString(),
                    ),
                  ],
                ),
                Positioned(
                  right: 12,
                  bottom: 0,
                  child: WeatherUnit(value: context.strings.airPollutionUnit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return const VerticalDivider(width: 50);
  }

  Widget _buildPollutionValue(String name, String wind) {
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
