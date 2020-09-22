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
        xAxisTitlesHeight,
      ),
      NormalChartTitle(
        Strings.cardTemperature.get(context),
        tempHeight,
      ),
      NormalChartTitle(
        Strings.cardRain.get(context),
        rainHeight,
      ),
      NormalChartTitle(
        Strings.chartWindMax.get(context),
        maxWindHeight,
      ),
      NormalChartTitle(
        Strings.chartWindAvg.get(context),
        avgWindHeight,
      ),
      NormalChartTitle(
        Strings.cardHumidity.get(context),
        humidityHeight,
      ),
      LegendChartTitle(
        Strings.cardAirPollutionShort.get(context),
        airPollutionHeight,
        KtList.of(
          ChartLegend(
            Strings.airPollutionPm1.get(context),
            airPollutionPm1Color,
          ),
          ChartLegend(
            Strings.airPollutionPm25.get(context),
            airPollutionPm25Color,
          ),
          ChartLegend(
            Strings.airPollutionPm10.get(context),
            airPollutionPm10Color,
          ),
        ),
      ),
      NormalChartTitle(
        Strings.cardPressure.get(context),
        pressureHeight,
      ),
    );
  }
}
