import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/presentation/home/current/widgets/half_circle_shape_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/hourly_weather_selected_date.dart';

class HourlyWeatherHeader extends StatelessWidget {
  final _changeDateButtonKey = GlobalKey<ProgressButtonState>();

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
          padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
          child: Column(
            children: [
              // SizedBox(height: 24),
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
                  key: _changeDateButtonKey,
                  text: 'Zmień dzień',
                  backgroundColor: Colors.white,
                  onPressed: () => _showDatePicker(context),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 06, 01),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      _changeDateButtonKey.currentState.show();
      context
          .bloc<HourlyWeatherBloc>()
          .add(HourlyWeatherEvent.onLoadClicked(selectedDate));
    }
  }
}
