import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_station_client/di/dependency_injection.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  FirebaseFirestore firestore = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather app"),
      ),
      body: FutureBuilder<QuerySnapshot<Object>>(
        future: firestore.collection("weathers").get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data =
                snapshot.requireData.docs.map((e) => e.data()).join("\n");
            return SingleChildScrollView(
              child: Text(data),
            );
          } else if (snapshot.error != null) {
            return SingleChildScrollView(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
