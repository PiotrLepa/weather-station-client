import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_to_wifi_result.freezed.dart';

@freezed
class ConnectToWifiResult with _$ConnectToWifiResult {
  const factory ConnectToWifiResult.connected() = Connected;

  const factory ConnectToWifiResult.error() = Error;
}
