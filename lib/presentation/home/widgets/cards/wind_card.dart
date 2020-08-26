import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/widgets/rounded_divider.dart';

class WindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff5858C5),
      iconPath: 'assets/icons/wind.svg',
      title: 'Wiatr (km/h)',
      body: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWindValue('Max', '19.8'),
                RoundedDivider(
                  size: 80,
                  thickness: 2,
                  color: Theme.of(context).dividerColor,
                  vertical: true,
                ),
                _buildWindValue('Średnia', '12.3'),
              ],
            ),
          ),
          SizedBox(height: 16),
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
