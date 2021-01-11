import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/enum_helper.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/data/model/fcm_message/fcm_message_model.dart';
import 'package:weather_station/data/model/fcm_message_type/fcm_message_type_model.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';

@lazySingleton
class FcmService {
  final FirebaseMessaging _firebaseMessaging;

  Stream<FcmMessageModel> _messages;

  FcmService(this._firebaseMessaging) {
    _messages = _getMessages();
  }

  Stream<NotificationModel> getRainDetectedMessages() {
    return _messages
        .where(
          (event) => _filterByType(event, FcmMessageTypeModel.RAIN_DETECTED),
        )
        .map((event) => event.notification);
  }

  bool _filterByType(FcmMessageModel model, FcmMessageTypeModel type) =>
      model.data[fcmMessageType] == enumToString(type);

  Stream<FcmMessageModel> _getMessages() {
    final controller = StreamController<FcmMessageModel>();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        logger.d('on message $message');
        controller.add(FcmMessageModel.customFromJson(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
        logger.d('on launch $message');
        controller.add(FcmMessageModel.customFromJson(message));
      },
      onResume: (Map<String, dynamic> message) async {
        logger.d('on launch $message');
        controller.add(FcmMessageModel.customFromJson(message));
      },
    );

    return controller.stream;
  }
}
