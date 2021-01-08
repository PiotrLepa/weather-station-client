import 'package:injectable/injectable.dart';
import 'package:weather_station/data/converter/entity/notification_converter.dart';
import 'package:weather_station/data/service/fcm_service.dart';
import 'package:weather_station/domain/entity/notification/notification.dart';
import 'package:weather_station/domain/repository/fcm_repository.dart';

@LazySingleton(as: FcmRepository)
class FcmRepositoryImpl extends FcmRepository {
  final FcmService _service;
  final NotificationConverter _notificationConverter;

  FcmRepositoryImpl(
    this._service,
    this._notificationConverter,
  );

  @override
  Stream<Notification> getRainDetected() {
    return _service
        .getRainDetectedMessages()
        .map(_notificationConverter.toEntity);
  }
}
