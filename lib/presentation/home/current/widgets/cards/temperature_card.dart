import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';

class TemperatureCard extends StatelessWidget {
  final double temperature;

  const TemperatureCard({
    Key key,
    @required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xfff0c419),
      iconPath: Assets.icons.temp.path,
      title: Strings.cardTemperature,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            '$temperature ${Strings.temperatureUnit.get(context)}',
            style: TextStyle(
              fontSize: scaleDimen(20),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
