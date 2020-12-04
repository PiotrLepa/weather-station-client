import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/hourly_weather/hourly_weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/air_pollution_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/avg_wind_speed_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/humidity_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/max_wind_speed_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/pressure_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/rain_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/temperature_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/painter/x_axis_titles_painter.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/vertical_dividers_painter.dart';

class WeatherChartContent extends StatelessWidget {
  static const chartOffset = 30.0;

  final KtList<HourlyWeather> weathers;
  final KtList<int> _timeSpots;
  final double _chartWidth;

  WeatherChartContent({
    Key key,
    @required this.weathers,
  })  : _timeSpots = weathers.map((w) => w.dateTime.millisecondsSinceEpoch),
        _chartWidth = weathers.size * spotWidth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _chartWidth + chartOffset + chartOffset,
      child: Stack(
        children: [
          _buildXAxisTitles(),
          _buildTemperature(context),
          _buildRain(context),
          _buildMaxWind(context),
          _buildAvgWind(context),
          _buildHumidity(context),
          _buildAirPollution(),
          _buildPressure(),
          _buildVerticalDividers(),
        ],
      ),
    );
  }

  Positioned _buildXAxisTitles() {
    return Positioned(
      left: chartOffset,
      child: CustomPaint(
        size: Size(_chartWidth, xAxisTitlesHeight),
        painter: XAxisTitlesPainter(
          xSpots: _timeSpots,
        ),
      ),
    );
  }

  Positioned _buildTemperature(BuildContext context) {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight,
      child: CustomPaint(
        size: Size(_chartWidth, tempHeight),
        painter: TemperaturePainter(
          tempSpots: weathers.map((e) => e.temperature),
          timeSpots: _timeSpots,
          unit: Strings.temperatureUnitShort.get(context),
        ),
      ),
    );
  }

  Positioned _buildRain(BuildContext context) {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight + tempHeight,
      child: CustomPaint(
        size: Size(_chartWidth, rainHeight),
        painter: RainPainter(
          rainSpots: weathers.map((e) => e.rainGauge),
          timeSpots: _timeSpots,
          unit: Strings.rainUnitShort.get(context),
        ),
      ),
    );
  }

  Positioned _buildMaxWind(BuildContext context) {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight + tempHeight + rainHeight,
      child: CustomPaint(
        size: Size(_chartWidth, maxWindHeight),
        painter: MaxWindSpeedPainter(
          speedSpots: weathers.map((w) => w.windSpeedMax),
          timeSpots: _timeSpots,
          strongWindText: Strings.strongWindSpeed.get(context),
          moderateWindText: Strings.moderateWindSpeed.get(context),
          weakWindText: Strings.weakWindSpeed.get(context),
        ),
      ),
    );
  }

  Positioned _buildAvgWind(BuildContext context) {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight + tempHeight + rainHeight + maxWindHeight,
      child: CustomPaint(
        size: Size(_chartWidth, avgWindHeight),
        painter: AvgWindSpeedPainter(
          speedSpots: weathers.map((w) => w.windSpeedAvg),
          timeSpots: _timeSpots,
          unit: Strings.windUnit.get(context),
        ),
      ),
    );
  }

  Positioned _buildHumidity(BuildContext context) {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight +
          tempHeight +
          rainHeight +
          maxWindHeight +
          avgWindHeight,
      child: CustomPaint(
        size: Size(_chartWidth, humidityHeight),
        painter: HumidityPainter(
          humiditySpots: weathers.map((w) => w.humidity),
          timeSpots: _timeSpots,
          unit: Strings.humidityUnit.get(context),
        ),
      ),
    );
  }

  Positioned _buildAirPollution() {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight +
          tempHeight +
          rainHeight +
          maxWindHeight +
          avgWindHeight +
          humidityHeight,
      child: CustomPaint(
        size: Size(_chartWidth, airPollutionHeight),
        painter: AirPollutionPainter(
          pm1Spots: weathers.map((w) => w.pm1),
          pm25Spots: weathers.map((w) => w.pm25),
          pm10Spots: weathers.map((w) => w.pm10),
          timeSpots: _timeSpots,
        ),
      ),
    );
  }

  Positioned _buildPressure() {
    return Positioned(
      left: chartOffset,
      top: xAxisTitlesHeight +
          tempHeight +
          rainHeight +
          maxWindHeight +
          avgWindHeight +
          humidityHeight +
          airPollutionHeight,
      child: CustomPaint(
        size: Size(_chartWidth, pressureHeight),
        painter: PressurePainter(
          pressureSpots: weathers.map((w) => w.pressure),
          timeSpots: _timeSpots,
        ),
      ),
    );
  }

  Positioned _buildVerticalDividers() {
    return Positioned(
      left: chartOffset,
      child: CustomPaint(
        size: Size(_chartWidth, heights.sum()),
        painter: VerticalDividersPainter(xSpots: _timeSpots),
      ),
    );
  }
}
