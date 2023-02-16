import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/model/weather_response.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/model/available_days_response.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<WeatherResponse> getLastWeather() => _firestore
          .collection("weathers")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get()
          .then((snapshot) {
        final data = snapshot.docs.first.data();
        return WeatherResponse.fromJson(data);
      });

  Future<List<AvailableDayResponse>> getAvailableDays() => _firestore
          .collection("savedDays")
          .doc("2023")
          .collection("2")
          .get()
          .then((snapshot) {
        return snapshot.docs
            .map((e) => e.data())
            .map((json) => AvailableDayResponse.fromJson(json))
            .toList();
      });
}
