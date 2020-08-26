import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_unit.dart';

class WindCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff5858C5),
      iconPath: 'assets/icons/wind.svg',
      title: 'Prędkość wiatru',
      body: Column(
        children: [
          Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWindValue('Max', '19.8'),
                    VerticalDivider(width: Dimens.scale(50)),
                    _buildWindValue('Średnia', '12.3'),
                  ],
                ),
              ),
              Positioned(
                right: 12,
                bottom: 0,
                child: WeatherUnit(value: 'km/h'),
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
          style: TextStyle(
            fontSize: Dimens.scale(15),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          wind,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Dimens.scale(20),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
