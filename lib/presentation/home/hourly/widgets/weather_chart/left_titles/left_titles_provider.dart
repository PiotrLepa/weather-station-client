import 'package:flutter/cupertino.dart';
import 'package:kt_dart/kt.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/legend_chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/normal_chart_title.dart';

class LeftTitlesProvider {
  static KtList<ChartTitle> getTitles(BuildContext context) {
    return KtList.of(
      NormalChartTitle(
        context.translateKey('weatherChartXAxisTitle'),
        xAxisTitlesHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardTemperature'),
        tempHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardRain'),
        rainHeight,
      ),
      NormalChartTitle(
        context.translateKey('chartWindMax'),
        maxWindHeight,
      ),
      NormalChartTitle(
        context.translateKey('chartWindAvg'),
        avgWindHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardHumidity'),
        humidityHeight,
      ),
      LegendChartTitle(
        context.translateKey('cardAirPollutionShort'),
        airPollutionHeight,
        KtList.of(
          ChartLegend(
            context.translateKey('airPollutionPm1'),
            airPollutionPm1Color,
          ),
          ChartLegend(
            context.translateKey('airPollutionPm25'),
            airPollutionPm25Color,
          ),
          ChartLegend(
            context.translateKey('airPollutionPm10'),
            airPollutionPm10Color,
          ),
        ),
      ),
      NormalChartTitle(
        context.translateKey('cardPressure'),
        pressureHeight,
      ),
    );
  }
}
