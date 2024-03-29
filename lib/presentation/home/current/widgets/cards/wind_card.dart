import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/current/widgets/weather_unit.dart';

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
      title: Strings.cardWind,
      body: Column(
        children: [
          Stack(
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildWindValue(
                      Strings.cardWindMax.get(context),
                      maxSpeed.toString(),
                    ),
                    VerticalDivider(width: scaleDimen(50)),
                    _buildWindValue(
                      Strings.cardWindAvg.get(context),
                      avgSpeed.toString(),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 12,
                bottom: 0,
                child: WeatherUnit(value: Strings.windUnit),
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
            fontSize: scaleDimen(15),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          wind,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: scaleDimen(20),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
