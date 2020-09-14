import 'package:flutter/material.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/air_pollution_card.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/humidity_card.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/pressure_card.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/rain_card.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/temperature_card.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/wind_card.dart';

class CurrentWeatherCards extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherCards({
    Key key,
    this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Row(
              children: [
                Expanded(
                  child: TemperatureCard(
                    temperature: weather.temperature,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: HumidityCard(
                    humidity: weather.humidity,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: RainCard(
                    rainGauge: weather.rainGauge,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                    child: PressureCard(
                  pressure: weather.pressure,
                )),
              ],
            ),
            SizedBox(height: 4),
            AirPollutionCard(
              pm1: weather.pm1,
              pm25: weather.pm25,
              pm10: weather.pm10,
            ),
            SizedBox(height: 4),
            WindCard(
              maxSpeed: weather.windSpeedMax,
              avgSpeed: weather.windSpeedAvg,
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
