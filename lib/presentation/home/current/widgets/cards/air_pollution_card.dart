import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/dimens.dart';
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
      title: KeyString('cardAirPollution'),
      body: Column(
        children: [
          IntrinsicHeight(
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPollutionValue(
                      context.translateKey('airPollutionPm1'),
                      pm1.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      context.translateKey('airPollutionPm25'),
                      pm25.toString(),
                    ),
                    _buildVerticalDivider(context),
                    _buildPollutionValue(
                      context.translateKey('airPollutionPm10'),
                      pm10.toString(),
                    ),
                  ],
                ),
                Positioned(
                  right: 12,
                  bottom: 0,
                  child: WeatherUnit(value: KeyString('airPollutionUnit')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    return VerticalDivider(width: scaleText(50));
  }

  Widget _buildPollutionValue(String name, String wind) {
    return Column(
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: scaleText(15),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          wind,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: scaleText(20),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
