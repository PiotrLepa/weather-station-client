import 'package:weather_station/domain/entity/notification/notification.dart';

abstract class FcmRepository {
  Stream<Notification> getRainDetected();
}
