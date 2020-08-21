import 'package:flutter/material.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/injection/injection.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Container(
        child: Column(
          children: [
            Text("HOME"),
            RaisedButton(
              onPressed: () {
                counter++;
                getIt<FlushbarHelper>()
                    .showError(message: counter.toString().toRawString());
              },
              child: Text("SHOW"),
            ),
            RaisedButton(
              onPressed: () {
                getIt<FlushbarHelper>().dismiss();
              },
              child: Text("HIDE"),
            ),
          ],
        ),
      ),
    );
  }
}
