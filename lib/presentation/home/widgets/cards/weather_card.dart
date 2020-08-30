import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/widgets/common/rounded_divider.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';

class WeatherCard extends StatelessWidget {
  final Color color;
  final String iconPath;
  final String title;
  final Widget body;

  const WeatherCard({
    Key key,
    @required this.color,
    @required this.iconPath,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.bloc<HomeBloc>().add(HomeEvent.onCardClicked());
      },
      child: Card(
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
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: Dimens.scale(28),
                  height: Dimens.scale(28),
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Dimens.scale(16),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            body,
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
