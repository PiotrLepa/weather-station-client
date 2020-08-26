import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/presentation/rounded_divider.dart';

class HumidityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          RoundedDivider(
            color: Color(0xff67e4dc),
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
                'assets/icons/humidity.svg',
                width: 24,
                height: 24,
              ),
              SizedBox(width: 4),
              Text(
                "Wilgotność",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            '54.6 %',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
