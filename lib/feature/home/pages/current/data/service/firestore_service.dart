import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/model/weather_response.dart';
import 'package:weather_station_client/feature/home/pages/hourly/data/model/available_days_response.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Stream<WeatherResponse> getLastWeather() => _firestore
          .collection("weathers")
          .orderBy("timestamp", descending: true)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        final data = snapshot.docs.first.data();
        return WeatherResponse.fromJson(data);
      });

  Future<List<AvailableDayResponse>> getAvailableDays() {
    final currentMonth = DateTime.now().month;
    final months = List<int>.generate(currentMonth, (i) => i + 1);
    final requests = months.map((month) => getAvailableDaysForMonth(month));
    return Future.wait(requests)
        .then((availableMonths) =>
            availableMonths.expand((availableDays) => availableDays).toList())
        .then((days) {
      if (days.isEmpty) {
        throw StateError("No saved days");
      } else {
        return days;
      }
    });
  }

  Future<List<AvailableDayResponse>> getAvailableDaysForMonth(int month) =>
      _firestore
          .collection("savedDays")
          .doc("2023")
          .collection(month.toString())
          .get()
          .then((snapshot) {
        final availableDays = snapshot.docs
            .map((e) => e.data())
            .map((json) => AvailableDayResponse.fromJson(json))
            .toList();

        availableDays.sort((dayResponse, otherDayResponse) =>
            dayResponse.day.compareTo(otherDayResponse.day));

        return availableDays;
      });

  Future<List<WeatherResponse>> getWeathersForDay(DateTime day) => _firestore
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
