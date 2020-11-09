import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/locale_provider.dart';

@lazySingleton
class NotificationSubscriber {
  static const topicRainDetector = 'rain_detector';

  final FirebaseMessaging _firebaseMessaging;
  final LocaleProvider _localeProvider;

  NotificationSubscriber(this._firebaseMessaging, this._localeProvider);

  Future<void> subscribe(String topic) async {
    await _firebaseMessaging.subscribeToTopic(_appendLanguageCode(topic));
  }

  Future<void> unsubscribe(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(_appendLanguageCode(topic));
  }

  String _appendLanguageCode(String topic) =>
      '${topic}_${_localeProvider.currentLanguageCode}';
}
