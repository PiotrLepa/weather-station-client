import 'package:flutter/material.dart';

class WeatherUnit extends StatelessWidget {
  final String value;

  const WeatherUnit({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
