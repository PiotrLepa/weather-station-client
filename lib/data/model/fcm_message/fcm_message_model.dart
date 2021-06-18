import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';

part 'fcm_message_model.freezed.dart';

@freezed
class FcmMessageModel with _$FcmMessageModel {
  const factory FcmMessageModel({
    required NotificationModel notification,
    required Map<String, dynamic> data,
  }) = _FcmMessageModel;

  static FcmMessageModel customFromJson(Map<String, dynamic> json) {
    return _$_FcmMessageModel(
      notification: NotificationModel.fromJson(
        (json['notification'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      data: (json['data'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
    );
  }
}
