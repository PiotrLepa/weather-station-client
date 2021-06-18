import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/enum_helper.dart';
import 'package:weather_station/data/model/fcm_message_type/fcm_message_type_model.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';

@lazySingleton
class FcmService {
  final Stream<RemoteMessage> _messages = _getMessages();

  Stream<NotificationModel> getRainDetectedMessages() {
    return _messages
        .where(
          (event) => _filterByType(event, FcmMessageTypeModel.RAIN_DETECTED),
        )
        .map(_parseNotification);
  }

  bool _filterByType(RemoteMessage event, FcmMessageTypeModel type) =>
      event.data[fcmMessageType] == enumToString(type);

  static Stream<RemoteMessage> _getMessages() => FirebaseMessaging.onMessage;

  static NotificationModel _parseNotification(RemoteMessage event) {
    final notification = event.notification!;
    return NotificationModel(
      title: notification.title!,
      body: notification.body!,
    );
  }
}
