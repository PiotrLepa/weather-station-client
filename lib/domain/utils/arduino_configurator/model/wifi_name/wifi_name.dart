import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_name.freezed.dart';

part 'wifi_name.g.dart';

@freezed
abstract class WifiName with _$WifiName {
  const factory WifiName({
    @required String name,
  }) = _WifiName;

  factory WifiName.fromJson(Map<String, dynamic> json) =>
      _$WifiNameFromJson(json);
  static const fromJsonFactory = _$WifiNameFromJson;
}
