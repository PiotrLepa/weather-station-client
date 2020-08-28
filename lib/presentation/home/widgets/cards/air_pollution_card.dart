import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/presentation/home/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/widgets/weather_unit.dart';

class AirPollutionCard extends StatelessWidget {
  final double pm1;
  final double pm25;
  final double pm10;

  const AirPollutionCard({
    Key key,
    @required this.pm1,
    @required this.pm25,
    @required this.pm10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff595959),
      iconPath: 'assets/icons/air-pollution.svg',
      title: 'Zanieczyszczenie',
      body: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPollutionValue('Pm 1', pm1.toString()),
                    _buildVerticalDivider(context),
                    _buildPollutionValue('Pm 2', pm25.toString()),
                    _buildVerticalDivider(context),
                    _buildPollutionValue('Pm 10', pm10.toString()),
                  ],
                ),
                Positioned(
                  right: 12,
                  bottom: 0,
                  child: WeatherUnit(value: 'μg/m\u00B3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return VerticalDivider(width: Dimens.scale(50));
  }

  Widget _buildPollutionValue(String name, String wind) {
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
