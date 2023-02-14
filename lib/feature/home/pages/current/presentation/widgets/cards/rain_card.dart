import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_value.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class RainCard extends StatelessWidget {
  final double precipitation;

  const RainCard({
    Key? key,
    required this.precipitation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff27C4FF),
      iconPath: Assets.icons.rain.path,
      title: context.strings.precipitation,
      body: WeatherValue(
        value: precipitation.toString(),
        unit: context.strings.precipitationUnit,
      ),
    );
  }
}
