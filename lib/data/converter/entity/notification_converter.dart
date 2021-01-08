import 'package:injectable/injectable.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';
import 'package:weather_station/domain/entity/notification/notification.dart';

@lazySingleton
class NotificationConverter {
  Notification toEntity(NotificationModel model) => Notification(
        title: model.title,
        body: model.body,
      );
}
