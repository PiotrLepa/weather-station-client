import 'package:flutter/material.dart';
import 'package:weather_station/presentation/humidity_card.dart';
import 'package:weather_station/presentation/temperature_card.dart';
import 'package:weather_station/presentation/wind_card.dart';

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
            WindCard(),
          ],
        ),
      ),
    );
  }
}
