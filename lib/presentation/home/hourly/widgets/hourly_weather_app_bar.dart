import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/presentation/home/current/widgets/half_circle_shape_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/hourly_weather_selected_date.dart';

class HourlyWeatherAppBar extends StatelessWidget {
  final _selectDateButtonKey = GlobalKey<ProgressButtonState>();

  final DateTime day;

  HourlyWeatherAppBar({
    Key key,
    @required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      backgroundColor: ThemeProvider.of(context).backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: CustomPaint(
          painter: HalfCircleShapePainter(
              color: ThemeProvider.of(context).primaryColor),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HourlyWeatherSelectedDate(day: day),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ProgressButton(
                    key: _selectDateButtonKey,
                    text: 'Zmień dzień',
                    color: Colors.white,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
