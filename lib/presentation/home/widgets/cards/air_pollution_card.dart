import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/widgets/rounded_divider.dart';

class AirPollutionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff595959),
      iconPath: 'assets/icons/air-pollution.svg',
      title: 'Zanieczyszczenie',
      body: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPollutionValue('Pm1', '10.2'),
                RoundedDivider(
                  size: 60,
                  thickness: 2,
                  color: Theme.of(context).dividerColor,
                  vertical: true,
                ),
                _buildPollutionValue('Pm2', '14.5'),
                RoundedDivider(
                  size: 60,
                  thickness: 2,
                  color: Theme
                      .of(context)
                      .dividerColor,
                  vertical: true,
                ),
                _buildPollutionValue('Pm10', '22.2'),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPollutionValue(String name, String wind) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          wind,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
