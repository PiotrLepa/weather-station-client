import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/rounded_divider.dart';

class WeatherCard extends StatelessWidget {
  final Color color;
  final String iconPath;
  final String title;
  final Widget body;

  const WeatherCard({
    Key? key,
    required this.color,
    required this.iconPath,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          RoundedDivider(
            color: color,
            size: 24,
            indent: 24,
            endIndent: 24,
            thickness: 4,
            radius: 12,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          body,
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
