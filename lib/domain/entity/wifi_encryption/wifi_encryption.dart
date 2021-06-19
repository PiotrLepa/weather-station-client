import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_encryption.freezed.dart';

@freezed
class WifiEncryption with _$WifiEncryption {
  const factory WifiEncryption.open() = Open;

  const factory WifiEncryption.wep() = Wep;

  const factory WifiEncryption.wpa() = Wpa;

  const factory WifiEncryption.wpa2() = Wpa2;
}
