import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PushNotificationsStorage {
  final SharedPreferences _prefs;

  static const String _arePushEnabledKey = '_arePushEnabledKey';

  PushNotificationsStorage(this._prefs);

  Future<bool> get arePushEnabled async =>
      _prefs.getBool(_arePushEnabledKey) ?? false;

  // ignore: avoid_positional_boolean_parameters
  Future<void> savePushEnabled(bool enabled) async {
    await _prefs.setBool(_arePushEnabledKey, enabled);
  }
}
