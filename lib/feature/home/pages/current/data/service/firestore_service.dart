import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/model/weather_response.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/model/available_days_response.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Stream<WeatherResponse> getLastWeather() =>
      _firestore
          .collection("weathers")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        final data = snapshot.docs.first.data();
        return WeatherResponse.fromJson(data);
      });

  Future<List<AvailableDayResponse>> getAvailableDays() =>
      _firestore
          .collection("savedDays")
          .doc("2023")
          .collection("2")
          .get()
          .then((snapshot) {
        final docs = snapshot.docs;
        if (docs.isEmpty) {
          throw StateError("No saved days");
        }

        final availableDays = docs
            .map((e) => e.data())
            .map((json) => AvailableDayResponse.fromJson(json))
            .toList();

        availableDays.sort((dayResponse, otherDayResponse) =>
            dayResponse.day.compareTo(otherDayResponse.day));

        return availableDays;
      });

  Future<List<WeatherResponse>> getWeathersForDay(DateTime day) =>
      _firestore
          .collection("weathers")
          .where(
        "timestamp",
        isGreaterThanOrEqualTo: Timestamp.fromDate(day),
        isLessThan: day.add(const Duration(days: 1)),
      )
          .get()
          .then((snapshot) {
        final docs = snapshot.docs;
        if (docs.isEmpty) {
          throw StateError("No weathers for day: $day");
        }

        return docs
            .map((document) => document.data())
            .map((json) => WeatherResponse.fromJson(json))
            .toList();
      });
}
