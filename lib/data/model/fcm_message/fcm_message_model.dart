import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';

part 'fcm_message_model.freezed.dart';

part 'fcm_message_model.g.dart';

@freezed
abstract class FcmMessageModel with _$FcmMessageModel {
  const factory FcmMessageModel({
    @required NotificationModel notification,
    @required Map<String, dynamic> data,
  }) = _FcmMessageModel;

  factory FcmMessageModel.fromJson(Map<String, dynamic> json) =>
      _$FcmMessageModelFromJson(json);
  static const fromJsonFactory = _$FcmMessageModelFromJson;
}
