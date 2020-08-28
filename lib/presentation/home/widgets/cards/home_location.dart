import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';

class HomeLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: ThemeProvider.of(context).backgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/marker.svg',
            width: 36,
            height: 36,
          ),
          SizedBox(width: 16),
          Text(
            'Tarnów',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Dimens.scale(22),
                color: ThemeProvider.of(context).textColor),
          )
        ],
      ),
    );
  }
}
