import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/air_pollution_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/avg_wind_speed_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/humidity_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/max_wind_speed_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/pressure_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/rain_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/temperature_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/painter/x_axis_titles_painter.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/vertical_dividers_painter.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class WeatherChartContent extends StatelessWidget {
  static const chartOffset = 30.0;

  final List<Weather> weathers;
  final List<int> _timeSpots;
  final double _chartWidth;

  WeatherChartContent({
    Key? key,
    required this.weathers,
  })  : _timeSpots = weathers
            .map((weather) => weather.timestamp.millisecondsSinceEpoch)
            .toList(),
        _chartWidth = (weathers.length - 1) * spotWidth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          tempSpots: weathers.map((e) => e.temperature).toList(),
          timeSpots: _timeSpots,
          unit: context.strings.temperatureUnitShort,
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
          rainSpots: weathers.map((e) => e.precipitation).toList(),
          timeSpots: _timeSpots,
          unit: context.strings.precipitationUnitShort,
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
          speedSpots: weathers.map((w) => w.windSpeedMax).toList(),
          timeSpots: _timeSpots,
          strongWindText: context.strings.strongWindSpeed,
          moderateWindText: context.strings.moderateWindSpeed,
          weakWindText: context.strings.weakWindSpeed,
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
          speedSpots: weathers.map((w) => w.windSpeedAvg).toList(),
          timeSpots: _timeSpots,
          unit: context.strings.windSpeedUnit,
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
          humiditySpots: weathers.map((w) => w.humidity).toList(),
          timeSpots: _timeSpots,
          unit: context.strings.humidityUnit,
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
          pm1Spots: weathers.map((w) => w.pm1).toList(),
          pm25Spots: weathers.map((w) => w.pm25).toList(),
          pm10Spots: weathers.map((w) => w.pm10).toList(),
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
          pressureSpots: weathers.map((w) => w.pressure).toList(),
          timeSpots: _timeSpots,
        ),
      ),
    );
  }

  Positioned _buildVerticalDividers() {
    return Positioned(
      left: chartOffset,
      child: CustomPaint(
        size: Size(_chartWidth, heights.reduce((sum, value) => sum + value)),
        painter: VerticalDividersPainter(xSpots: _timeSpots),
      ),
    );
  }
}
