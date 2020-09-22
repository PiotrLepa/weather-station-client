import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/current/widgets/weather_unit.dart';

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
      iconPath: Assets.icons.airPollution.path,
      title: Strings.cardAirPollution,
      body: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPollutionValue(
                      Strings.airPollutionPm1.get(context),
                      pm1.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      Strings.airPollutionPm25.get(context),
                      pm25.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      Strings.airPollutionPm10.get(context),
                      pm10.toString(),
                    ),
                  ],
                ),
                Positioned(
                  right: 12,
                  bottom: 0,
                  child: WeatherUnit(value: Strings.airPollutionUnit),
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
