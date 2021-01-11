import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class UtilsModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  BleManager get bleManger => BleManager();

  @lazySingleton
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();
}
