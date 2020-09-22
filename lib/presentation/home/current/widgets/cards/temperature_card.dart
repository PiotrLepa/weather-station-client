import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';

class TemperatureCard extends StatelessWidget {
  final int temperature;

  const TemperatureCard({
    Key key,
    @required this.temperature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xfff0c419),
      iconPath: Assets.icons.temp.path,
      title: KeyString('cardTemperature'),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          Text(
            '$temperature ${context.translateKey('temperatureUnit')}',
            style: TextStyle(
              fontSize: scaleText(20),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.arrow_upward,
            color: const Color(0xfff0c419),
            size: scaleText(16),
          ),
        ],
      ),
    );
  }
}
