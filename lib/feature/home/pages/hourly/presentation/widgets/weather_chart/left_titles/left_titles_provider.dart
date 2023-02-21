import 'package:flutter/cupertino.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/chart_constants.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/left_titles/chart_title.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/left_titles/legend_chart_title.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/left_titles/normal_chart_title.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class LeftTitlesProvider {
  static List<ChartTitle> getTitles(BuildContext context) {
    return [
      NormalChartTitle(
        context.strings.weatherChartXAxisTitle,
        xAxisTitlesHeight,
      ),
      NormalChartTitle(
        context.strings.temperature,
        tempHeight,
      ),
      NormalChartTitle(
        context.strings.precipitation,
        rainHeight,
      ),
      NormalChartTitle(
        context.strings.chartWindMax,
        maxWindHeight,
      ),
      NormalChartTitle(
        context.strings.chartWindAvg,
        avgWindHeight,
      ),
      NormalChartTitle(
        context.strings.humidity,
        humidityHeight,
      ),
      LegendChartTitle(
        context.strings.cardAirPollutionShort,
        airPollutionHeight,
        [
          ChartLegend(
            context.strings.airPollutionPm1,
            airPollutionPm1Color,
          ),
          ChartLegend(
            context.strings.airPollutionPm25,
            airPollutionPm25Color,
          ),
          ChartLegend(
            context.strings.airPollutionPm10,
            airPollutionPm10Color,
          ),
        ],
      ),
      NormalChartTitle(
        context.strings.pressure,
        pressureHeight,
      ),
    ];
  }
}
