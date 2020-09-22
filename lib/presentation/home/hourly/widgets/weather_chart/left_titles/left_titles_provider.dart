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
        ChartConstants.xAxisTitlesHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardTemperature'),
        ChartConstants.tempHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardRain'),
        ChartConstants.rainHeight,
      ),
      NormalChartTitle(
        context.translateKey('chartWindMax'),
        ChartConstants.maxWindHeight,
      ),
      NormalChartTitle(
        context.translateKey('chartWindAvg'),
        ChartConstants.avgWindHeight,
      ),
      NormalChartTitle(
        context.translateKey('cardHumidity'),
        ChartConstants.humidityHeight,
      ),
      LegendChartTitle(
        context.translateKey('cardAirPollutionShort'),
        ChartConstants.airPollutionHeight,
        KtList.of(
          ChartLegend(
            context.translateKey('airPollutionPm1'),
            ChartConstants.airPollutionPm1Color,
          ),
          ChartLegend(
            context.translateKey('airPollutionPm25'),
            ChartConstants.airPollutionPm25Color,
          ),
          ChartLegend(
            context.translateKey('airPollutionPm10'),
            ChartConstants.airPollutionPm10Color,
          ),
        ),
      ),
      NormalChartTitle(
        context.translateKey('cardPressure'),
        ChartConstants.pressureHeight,
      ),
    );
  }
}
