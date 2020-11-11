import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/converter/converter.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';
import 'package:weather_station/domain/entity/notification/notification.dart';

@lazySingleton
class NotificationEntityConverter
    implements Converter<NotificationModel, Notification> {
  @override
  Notification convert(NotificationModel model) => Notification(
        title: model.title,
        body: model.body,
      );
}
