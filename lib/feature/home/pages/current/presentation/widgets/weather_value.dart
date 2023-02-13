import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/weather_unit.dart';

class WeatherValue extends StatelessWidget {
  final String value;
  final String unit;

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
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        WeatherUnit(value: unit),
      ],
    );
  }
}
