import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/data/model/wifi_encryption/wifi_encryption_model.dart';

part 'wifi_model.freezed.dart';
part 'wifi_model.g.dart';

@freezed
abstract class WifiModel with _$WifiModel {
  const factory WifiModel({
    @required String name,
    @required WifiEncryptionModel encryption,
    @required int rssi,
  }) = _WifiModel;

  factory WifiModel.fromJson(Map<String, dynamic> json) =>
      _$WifiModelFromJson(json);
  static const fromJsonFactory = _$WifiModelFromJson;
}
