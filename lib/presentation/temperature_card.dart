import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/presentation/rounded_divider.dart';

class TemperatureCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          RoundedDivider(
            color: Color(0xfff0c419),
            height: 24,
            indent: 24,
            endIndent: 24,
            thickness: 4,
            radius: 12,
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/temp.svg',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 4),
              Text(
                "Temperatura",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Text(
                '23 °C',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_upward,
                color: Color(0xfff0c419),
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
