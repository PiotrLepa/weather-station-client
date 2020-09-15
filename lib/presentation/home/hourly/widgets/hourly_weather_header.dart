import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/presentation/home/current/widgets/half_circle_shape_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/hourly_weather_selected_date.dart';

class HourlyWeatherHeader extends StatelessWidget {
  final _selectDateButtonKey = GlobalKey<ProgressButtonState>();

  final DateTime day;

  HourlyWeatherHeader({
    Key key,
    @required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final padding = 24.0;

    return Container(
      color: ThemeProvider.of(context).backgroundColor,
      child: CustomPaint(
        painter: HalfCircleShapePainter(
          color: ThemeProvider.of(context).primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Row(
                children: [
                  HourlyWeatherSelectedDate(day: day),
                  SizedBox(width: padding),
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/icons/weather_graph.svg',
                      width: 72,
                      height: 72,
                    ),
                  )
                ],
              ),
              SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: ProgressButton(
                  key: _selectDateButtonKey,
                  text: 'Zmień dzień',
                  color: Colors.white,
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
