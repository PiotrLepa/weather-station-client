import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/locale_provider.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/domain/utils/storage/push_notifications_storage.dart';

@lazySingleton
class NotificationSubscriber {
  static const topicRainDetected = 'rain_detected';

  final FirebaseMessaging _firebaseMessaging;
  final LocaleProvider _localeProvider;
  final PushNotificationsStorage _pushNotificationsStorage;

  NotificationSubscriber(
    this._firebaseMessaging,
    this._localeProvider,
    this._pushNotificationsStorage,
  );

  Future<bool> get arePushEnabled async =>
      _pushNotificationsStorage.arePushEnabled;

  Future<void> subscribe(String topic) async {
    if (await _hasConnection()) {
      await _firebaseMessaging.subscribeToTopic(_appendLanguageCode(topic));
      await _pushNotificationsStorage.savePushEnabled(true);
    } else {
      return Future.error(const NoConnection());
    }
  }

  Future<void> unsubscribe(String topic) async {
    if (await _hasConnection()) {
      await _firebaseMessaging.unsubscribeFromTopic(_appendLanguageCode(topic));
      await _pushNotificationsStorage.savePushEnabled(false);
    } else {
      return Future.error(const NoConnection());
    }
  }

  Future<bool> _hasConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  String _appendLanguageCode(String topic) =>
      '${topic}_${_localeProvider.currentLanguageCode}';
}
