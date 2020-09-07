import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/humidity_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/left_titles_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/rain_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/temperature_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/vertical_dividers_painter.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/wind_speed_painter.dart';
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
    final leftTitles =
        ChartConstants.leftTitles.map((title) => context.translate(title));
    final leftTitlesWidth = leftTitles[1].length * 10.0;
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
            left: leftTitlesWidth + chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempChartHeight +
                ChartConstants.rainChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.windChartHeight),
              painter: WindSpeedPainter(
                // maxSpeeds: weathers.map((e) => e.windSpeedMax),
                // avgSpeeds: weathers.map((e) => e.windSpeedAvg),
                maxSpeeds: _getFakeMaxWeatherSpeeds(),
                avgSpeeds: _getFakeMinWeathersSpeed(),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: leftTitlesWidth + chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempChartHeight +
                ChartConstants.rainChartHeight +
                ChartConstants.windChartHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.humidityChartHeight),
              painter: HumidityPainter(
                humidity: weathers.map((w) => w.humidity),
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

  KtList<double> _getFakeMinWeathersSpeed() => KtList.from([
        13.0,
        11.2,
        2.3,
        4.8,
        13.2,
        13.0,
        11.2,
        2.3,
        4.8,
        11.2,
        13.0,
        11.2,
        2.3,
        4.8,
        11.2,
        13.0,
        11.2,
        2.3,
        4.8,
        11.2,
        13.0,
        11.2,
        2.3,
        4.8
      ]);

  KtList<double> _getFakeMaxWeatherSpeeds() =>
      KtList.from([
        23.0,
        24.2,
        5.3,
        7.8,
        13.2,
        23.0,
        24.2,
        5.3,
        7.8,
        13.2,
        23.0,
        24.2,
        5.3,
        7.8,
        13.2,
        23.0,
        24.2,
        5.3,
        7.8,
        13.2,
        23.0,
        24.2,
        5.3,
        7.8
      ]);
}
