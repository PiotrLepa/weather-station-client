import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/vertical_dividers_painter.dart';

import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/avg_wind_speed_painter.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/max_wind_speed_painter.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/rain_painter.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/temperature_painter.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/hourly_weather/weather_chart/painter/x_axis_titles_painter.dart';

class WeatherChart extends StatelessWidget {
  final KtList<Weather> weathers;
  final KtList<int> _datesMillis;
  final double _chartWidth;

  WeatherChart({
    Key key,
    @required this.weathers,
  })  : _datesMillis = weathers.map((w) => w.date.millisecondsSinceEpoch),
        _chartWidth = weathers.size * ChartConstants.spotWidth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final chartOffset = 30.0;

    return Container(
      width: _chartWidth + chartOffset + chartOffset,
      child: Stack(
        children: [
          Positioned(
            left: chartOffset,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.xAxisTitlesHeight),
              painter: XAxisTitlesPainter(
                xSpots: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.tempChartHeight),
              painter: TemperaturePainter(
                temps: weathers.map((e) => e.temperature),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.rainChartHeight),
              painter: RainPainter(
                rains: weathers.map((e) => e.rainGauge),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempChartHeight +
                ChartConstants.rainChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.maxWindChartHeight),
              painter: MaxWindSpeedPainter(
                speeds: weathers.map((w) => w.windSpeedMax),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempChartHeight +
                ChartConstants.rainChartHeight +
                ChartConstants.avgWindChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.avgWindChartHeight),
              painter: AvgWindSpeedPainter(
                speeds: weathers.map((w) => w.windSpeedAvg),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.heights.sum()),
              painter: VerticalDividersPainter(xSpots: _datesMillis),
            ),
          ),
        ],
      ),
    );
  }
}
