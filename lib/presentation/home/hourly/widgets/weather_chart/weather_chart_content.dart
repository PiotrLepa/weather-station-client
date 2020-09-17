import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/air_pollution_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/avg_wind_speed_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/max_wind_speed_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/rain_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/temperature_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/x_axis_titles_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/vertical_dividers_painter.dart';

class WeatherChartContent extends StatelessWidget {
  final KtList<Weather> weathers;
  final KtList<int> _datesMillis;
  final double _chartWidth;

  WeatherChartContent({
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
              size: Size(_chartWidth, ChartConstants.tempHeight),
              painter: TemperaturePainter(
                temps: weathers.map((e) => e.temperature),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight + ChartConstants.tempHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.rainHeight),
              painter: RainPainter(
                rains: weathers.map((e) => e.rainGauge),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempHeight +
                ChartConstants.rainHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.maxWindHeight),
              painter: MaxWindSpeedPainter(
                speeds: weathers.map((w) => w.windSpeedMax),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempHeight +
                ChartConstants.rainHeight +
                ChartConstants.maxWindHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.avgWindHeight),
              painter: AvgWindSpeedPainter(
                speeds: weathers.map((w) => w.windSpeedAvg),
                dateMillis: _datesMillis,
              ),
            ),
          ),
          Positioned(
            left: chartOffset,
            top: ChartConstants.xAxisTitlesHeight +
                ChartConstants.tempHeight +
                ChartConstants.rainHeight +
                ChartConstants.maxWindHeight +
                ChartConstants.avgWindHeight,
            child: CustomPaint(
              size: Size(_chartWidth, ChartConstants.airPollutionHeight),
              painter: AirPollutionPainter(
                pm1Spots: weathers.map((w) => w.pm1),
                pm25Spots: weathers.map((w) => w.pm25),
                pm10Spots: weathers.map((w) => w.pm10),
                // pm1Spots: getFakeSpots(),
                // pm25Spots: getFakeSpots(),
                // pm10Spots: getFakeSpots(),
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

  KtList<double> getFakeSpots() {
    return KtList.from([
      13.2,
      15.3,
      14.5,
      17.1,
      25.3,
      22.4,
      13.2,
      15.3,
      14.5,
      17.1,
      25.3,
      22.4,
      13.2,
      15.3,
      14.5,
      17.1,
      25.3,
      22.4,
      13.2,
      15.3,
      14.5,
      17.1,
      25.3,
      22.4,
    ]);
  }
}
