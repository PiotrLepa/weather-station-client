import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/charts/line_chart_painter.dart';

class WeatherChart extends StatelessWidget {
  final KtList<Weather> weathers;

  WeatherChart({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(
        // temps: weathers.map((e) => e.temperature),
        // hours: weathers.map((e) => e.date.hour),
        temps: KtList.of(29, 30, 30, 29, 32),
        hours: weathers.map((e) => e.date.hour).subList(0, 5),
      ),
    );
  }
}
