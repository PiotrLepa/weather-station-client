import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/left_titles_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/rain_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/temperature_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/vertical_dividers_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/x_axis_titles_painter.dart';

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
    final leftTitles = ChartConstants.leftTitles.map((title) =>
        context.translate(title));
    final leftTitlesWidth = leftTitles
        .max()
        .length * 10.0;
    final chartOffset = 24.0;

    return Container(
      width: leftTitlesWidth + _chartWidth + chartOffset + chartOffset,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(
              leftTitlesWidth,
              ChartConstants.heights.sum(),
            ),
            painter: LeftTitlesPainter(
              itemsHeights: ChartConstants.heights,
              titles: leftTitles,
            ),
          ),
          Positioned(
            left: leftTitlesWidth + chartOffset,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.xAxisTitlesHeight),
              painter: XAxisTitlesPainter(
                xSpots: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: leftTitlesWidth + chartOffset,
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
            left: leftTitlesWidth + chartOffset,
            top:
            ChartConstants.xAxisTitlesHeight + ChartConstants.tempChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.rainChartHeight),
              painter: RainPainter(
                rains: weathers.map((e) => e.rainGauge),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: leftTitlesWidth + chartOffset,
            child: CustomPaint(
                size: Size(_chartWidth, ChartConstants.heights.sum()),
                painter: VerticalDividersPainter(
                  xSpots: _datesMillis,
                )),
          ),
        ],
      ),
    );
  }
}
