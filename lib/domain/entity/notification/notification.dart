import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String title,
    required String body,
  }) = _Notification;
}
