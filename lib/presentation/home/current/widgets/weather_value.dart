import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/presentation/home/current/widgets/weather_unit.dart';

class WeatherValue extends StatelessWidget {
  final String value;
  final PlainLocalizedString unit;

  const WeatherValue({
    Key? key,
    required this.value,
    required this.unit,
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
            fontSize: scaleDimen(20),
            fontWeight: FontWeight.w900,
          ),
        ),
        WeatherUnit(value: unit),
      ],
    );
  }
}
