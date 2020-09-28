import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';

@module
abstract class UtilsModule {
  @lazySingleton
  BleManager get bleManger => BleManager();
}
