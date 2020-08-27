import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';

import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/home/widgets/weather_unit.dart';

class WeatherValue extends StatelessWidget {
  final String value;
  final String unit;

  const WeatherValue({
    Key key,
    @required this.value,
    @required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$value ',
          style: TextStyle(
            fontSize: Dimens.scale(20),
            fontWeight: FontWeight.w900,
          ),
        ),
        WeatherUnit(
          value: unit,
        ),
      ],
    );
  }
}
