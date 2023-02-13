import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/data/model/weather_response.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<WeatherResponse> getLastWeather() =>
      _firestore.collection("weathers").limit(1).get().then((snapshot) {
        final data = snapshot.docs.first.data();
        return WeatherResponse.fromJson(data);
      }).catchError((error, stackTrace) {
        final a = 5;
        Future.error(error);
      });
}
