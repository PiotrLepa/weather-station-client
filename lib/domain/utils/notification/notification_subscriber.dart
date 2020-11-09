import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/locale_provider.dart';
import 'package:weather_station/domain/utils/storage/push_notifications_storage.dart';

@lazySingleton
class NotificationSubscriber {
  static const topicRainDetector = 'rain_detector';

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
    await _firebaseMessaging.subscribeToTopic(_appendLanguageCode(topic));
    await _pushNotificationsStorage.savePushEnabled(true);
  }

  Future<void> unsubscribe(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(_appendLanguageCode(topic));
    await _pushNotificationsStorage.savePushEnabled(false);
  }

  String _appendLanguageCode(String topic) =>
      '${topic}_${_localeProvider.currentLanguageCode}';
}
