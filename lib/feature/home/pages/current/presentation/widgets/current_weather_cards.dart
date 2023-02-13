import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/air_pollution_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/humidity_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/pressure_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/rain_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/temperature_card.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/cards/wind_card.dart';

class CurrentWeatherCards extends StatelessWidget {
  final Weather weather;

  const CurrentWeatherCards({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
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
                const SizedBox(width: 4),
                Expanded(
                  child: HumidityCard(
                    humidity: weather.humidity,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: RainCard(
                    precipitation: weather.precipitation,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                    child: PressureCard(
                  pressure: weather.pressure,
                )),
              ],
            ),
            const SizedBox(height: 4),
            AirPollutionCard(
              pm1: weather.pm1,
              pm25: weather.pm25,
              pm10: weather.pm10,
            ),
            const SizedBox(height: 4),
            WindCard(
              maxSpeed: weather.windSpeedMax,
              avgSpeed: weather.windSpeedAvg,
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
