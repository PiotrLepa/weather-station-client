import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/left_titles_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/temperature_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/vertical_dividers_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/x_asix_titles_painter.dart';

class WeatherChart extends StatelessWidget {
  final _topTitlesHeight = 50.0;
  final _tempChartHeight = 200.0;
  final double _itemsHeight = 250.0; // TODO to separate class

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.amber,
          child: CustomPaint(
            size: Size(100, _itemsHeight),
            painter: LeftTitlesPainter(
              itemsHeights: KtList.of(_topTitlesHeight, _tempChartHeight),
              titles: KtList.of('Godzina', 'Temperatura'),
            ),
          ),
        ),
        SizedBox(width: 12),
        CustomPaint(
          painter: VerticalDividersPainter(
            xSpots: _datesMillis,
          ),
          child: Column(
            children: [
              CustomPaint(
                size: Size(_chartWidth, _topTitlesHeight),
                painter: XAxisTitlesPainter(
                  xSpots: _datesMillis,
                ),
              ),
              CustomPaint(
                size: Size(_chartWidth, _tempChartHeight),
                painter: TemperaturePainter(
                  // temps: weathers.map((e) => e.temperature),
                  temps: KtList.of(30, 28, 29, 30),
                  dateMillis: _datesMillis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
