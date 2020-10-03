import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_credentials.freezed.dart';
part 'wifi_credentials.g.dart';

@freezed
abstract class WifiCredentials with _$WifiCredentials {
  const factory WifiCredentials({
    @required String name,
    @required String password,
  }) = _WifiCredentials;

  factory WifiCredentials.fromJson(Map<String, dynamic> json) =>
      _$WifiCredentialsFromJson(json);

  static const fromJsonFactory = _$WifiCredentialsFromJson;
}
