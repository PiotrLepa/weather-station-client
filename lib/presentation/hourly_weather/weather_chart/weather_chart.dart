import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/temperature_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/top_titles_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/vertical_dividers_painter.dart';

class WeatherChart extends StatelessWidget {
  final KtList<Weather> weathers;
  final KtList<int> _datesMillis;
  final double _chartWidth;

  WeatherChart({
    Key key,
    @required this.weathers,
  })  : _datesMillis = weathers.map((w) => w.date.millisecondsSinceEpoch),
        _chartWidth = weathers.size * 50.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: VerticalDividersPainter(
        xSpots: _datesMillis,
      ),
      child: Column(
        children: [
          CustomPaint(
            size: Size(_chartWidth, 80),
            painter: TopTitlesPainter(
              xSpots: _datesMillis,
            ),
          ),
          CustomPaint(
            size: Size(_chartWidth, 200),
            painter: TemperaturePainter(
              temps: weathers.map((e) => e.temperature),
              dateMillis: _datesMillis,
            ),
          ),
        ],
      ),
    );
  }
}
