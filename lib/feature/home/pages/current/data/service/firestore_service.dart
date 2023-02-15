import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/extensions/date_time_extensions.dart';
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

  Future<AvailableDaysResponse> getAvailableDays() =>
      _firestore.collection("helpers").doc("savedDays").get().then((snapshot) {
        final array = snapshot.data()!["days"] as List<dynamic>;
        final days = parseDays(array);
        return AvailableDaysResponse(days: days.toList());
      });

  Iterable<DateTime> parseDays(List<dynamic> array) => array
      .map((field) => field as Timestamp)
      .map((timestamp) => timestamp.toDate())
      .map((date) => date.copyWith(millisecond: 0));
}
