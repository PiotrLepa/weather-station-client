import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';

class WeatherUnit extends StatelessWidget {
  final PlainLocalizedString value;

  const WeatherUnit({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        value.get(context),
        style: TextStyle(
          fontSize: Dimens.scale(16),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
