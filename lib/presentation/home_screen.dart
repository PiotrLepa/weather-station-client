import 'package:flutter/material.dart';
import 'package:weather_station/presentation/cards/air_pollution_card.dart';
import 'package:weather_station/presentation/cards/pressure_card.dart';

import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/cards/humidity_card.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/cards/rain_card.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/cards/temperature_card.dart';
import 'file:///C:/Users/Piotr/IdeaProjects/weather_station/lib/presentation/cards/wind_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    final padding = 8.0;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: GridView.count(
          childAspectRatio: 1.35,
          padding: EdgeInsets.all(padding),
          crossAxisSpacing: padding,
          mainAxisSpacing: padding,
          crossAxisCount: 2,
          children: [
            TemperatureCard(),
            HumidityCard(),
            RainCard(),
            WindCard(),
            PressureCard(),
            AirPollutionCard(),
          ],
        ),
      ),
    );
  }
}
