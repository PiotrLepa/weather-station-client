import 'package:flutter/cupertino.dart';
import 'package:kt_dart/kt.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/legend_chart_title.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/left_titles/normal_chart_title.dart';

class LeftTitlesProvider {
  static KtList<ChartTitle> getTitles(BuildContext context) {
    return KtList.of(
      NormalChartTitle(
        Strings.weatherChartXAxisTitle.get(context),
        ChartConstants.xAxisTitlesHeight,
      ),
      NormalChartTitle(
        Strings.cardTemperature.get(context),
        ChartConstants.tempHeight,
      ),
      NormalChartTitle(
        Strings.cardRain.get(context),
        ChartConstants.rainHeight,
      ),
      NormalChartTitle(
        Strings.chartWindMax.get(context),
        ChartConstants.maxWindHeight,
      ),
      NormalChartTitle(
        Strings.chartWindAvg.get(context),
        ChartConstants.avgWindHeight,
      ),
      NormalChartTitle(
        Strings.cardHumidity.get(context),
        ChartConstants.humidityHeight,
      ),
      LegendChartTitle(
        Strings.cardAirPollutionShort.get(context),
        ChartConstants.airPollutionHeight,
        KtList.of(
          ChartLegend(
            Strings.airPollutionPm1.get(context),
            ChartConstants.airPollutionPm1Color,
          ),
          ChartLegend(
            Strings.airPollutionPm25.get(context),
            ChartConstants.airPollutionPm25Color,
          ),
          ChartLegend(
            Strings.airPollutionPm10.get(context),
            ChartConstants.airPollutionPm10Color,
          ),
        ),
      ),
      NormalChartTitle(
        Strings.cardPressure.get(context),
        ChartConstants.pressureHeight,
      ),
    );
  }
}
