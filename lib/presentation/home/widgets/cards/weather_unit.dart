import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';

class WeatherUnit extends StatelessWidget {
  final String value;

  const WeatherUnit({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        value,
        style: TextStyle(
          fontSize: Dimens.scale(16),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
