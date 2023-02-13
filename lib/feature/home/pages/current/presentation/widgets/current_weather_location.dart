import 'package:flutter/material.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class HomeLocation extends StatelessWidget {
  final String location;

  const HomeLocation({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ThemeProvider.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.marker.svg(
            width: 36,
            height: 36,
          ),
          const SizedBox(width: 16),
          Text(
            location,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: ThemeProvider.of(context).textColor),
          )
        ],
      ),
    );
  }
}
