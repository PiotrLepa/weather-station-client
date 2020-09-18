import 'package:flutter/cupertino.dart';
import 'package:kt_dart/kt.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/legend_chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/normal_chart_title.dart';

class LeftTitlesProvider {
  static KtList<ChartTitle> getTitles(BuildContext context) {
    return KtList.of(
      NormalChartTitle('Godzina', ChartConstants.xAxisTitlesHeight),
      NormalChartTitle('Temperatura', ChartConstants.tempHeight),
      NormalChartTitle('Opady', ChartConstants.rainHeight),
      NormalChartTitle('Porywy\nwiatru', ChartConstants.maxWindHeight),
      NormalChartTitle('Prędkość\nwiatru', ChartConstants.avgWindHeight),
      NormalChartTitle('Wilgotność', ChartConstants.humidityHeight),
      LegendChartTitle(
        'Smog',
        ChartConstants.airPollutionHeight,
        KtList.of(
          ChartLegend('Pm 1', ChartConstants.airPollutionPm1Color),
          ChartLegend('Pm 2.5', ChartConstants.airPollutionPm25Color),
          ChartLegend('Pm 10', ChartConstants.airPollutionPm10Color),
        ),
      ),
    );
  }
}
