import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';

class TemperatureChart extends StatelessWidget {
  final KtList<int> temperatures;
  final KtList<DateTime> dates;
  final KtList<int> _dateHours;
  final int _maxTemp;
  final int _minTemp;
  final int _tempStep;

  TemperatureChart({
    Key key,
    @required this.temperatures,
    @required this.dates,
  })  : _maxTemp = temperatures.max(),
        _minTemp = temperatures.min(),
        _tempStep = ((temperatures.max() - temperatures.min()) / 5).ceil(),
        _dateHours = dates.map((date) => date.hour),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 200,
        width: temperatures.size * 25.0,
        padding: EdgeInsets.fromLTRB(0, 24, 24, 0),
        child: LineChart(
          _getLineChartData(context),
        ),
      ),
    );
  }

  LineChartData _getLineChartData(BuildContext context) {
    final lineChartBarData = LineChartBarData(
      isCurved: true,
      spots: temperatures
          .mapIndexed((index, temp) => FlSpot(
                _dateHours[index].toDouble(),
                temp.toDouble(),
              ))
          .asList(),
    );
    return LineChartData(
      minY: _minTemp - _tempStep.toDouble(),
      maxY: _maxTemp + _tempStep.toDouble(),
      lineBarsData: [lineChartBarData],
      showingTooltipIndicators: temperatures
          .mapIndexed(
            (index, temp) => ShowingTooltipIndicators(index, [
              LineBarSpot(
                lineChartBarData,
                0,
                lineChartBarData.spots[index],
              )
            ]),
          )
          .asList(),
      lineTouchData: LineTouchData(
        enabled: false,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipRoundedRadius: 8,
          getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
            return lineBarsSpot.map((lineBarSpot) {
              return LineTooltipItem(
                lineBarSpot.y.toInt().toString(),
                const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        leftTitles: SideTitles(
          showTitles: true,
          getTitles: _getLeftTitles,
          reservedSize: 28,
          margin: 12,
          interval: _tempStep.toDouble(),
        ),
        bottomTitles: SideTitles(
          showTitles: true,
          getTitles: _getBottomTitles,
          margin: 12,
          textStyle: TextStyle(
            fontSize: Dimens.scale(14),
            color: ThemeProvider.of(context).textColor,
          ),
        ),
      ),
    );
  }

  bool _checkToShowTitle(
    double minValue,
    double maxValue,
    SideTitles sideTitles,
    double appliedInterval,
    double value,
  ) {
    return value % 2 == 0;
  }

  String _getLeftTitles(double value) {
    return value.toInt().toString();
  }

  String _getBottomTitles(double value) {
    final dateIndex = _dateHours.indexOf(value.toInt());
    if (dateIndex == -1) return '';
    return dates[dateIndex].hour.toString();
  }
}
