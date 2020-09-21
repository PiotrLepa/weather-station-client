import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/dimens.dart';

class WeatherUnit extends StatelessWidget {
  final RKString value;

  const WeatherUnit({
    Key key,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        context.translate(value),
        style: TextStyle(
          fontSize: Dimens.scale(16),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
