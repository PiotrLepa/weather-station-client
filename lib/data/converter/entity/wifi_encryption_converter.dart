import 'package:injectable/injectable.dart';
import 'package:weather_station/data/model/wifi_encryption/wifi_encryption_model.dart';
import 'package:weather_station/domain/entity/wifi_encryption/wifi_encryption.dart';

@lazySingleton
class WifiEncryptionConverter {
  // ignore: missing_return
  WifiEncryption toEntity(WifiEncryptionModel model) {
    switch (model) {
      case WifiEncryptionModel.open:
        return const WifiEncryption.open();
      case WifiEncryptionModel.wep:
        return const WifiEncryption.wep();
      case WifiEncryptionModel.wpa:
        return const WifiEncryption.wpa();
      case WifiEncryptionModel.wpa2:
        return const WifiEncryption.wpa2();
    }
  }
}
