import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';
import 'package:weather_station/presentation/home/current/widgets/weather_value.dart';

class PressureCard extends StatelessWidget {
  final int pressure;

  const PressureCard({
    Key key,
    @required this.pressure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff00347b),
      iconPath: Assets.icons.pressure.path,
      title: Strings.cardPressure,
      body: WeatherValue(
        value: pressure.toString(),
        unit: Strings.pressureUnit,
      ),
    );
  }
}
