import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/weather_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_value.dart';
import 'package:weather_station_client/gen/assets.gen.dart';

class PressureCard extends StatelessWidget {
  final int pressure;

  const PressureCard({
    Key? key,
    required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff00347b),
      iconPath: Assets.icons.pressure.path,
      title: "Ciśnienie",
      body: WeatherValue(
        value: pressure.toString(),
        unit: "hpa",
      ),
    );
  }
}
