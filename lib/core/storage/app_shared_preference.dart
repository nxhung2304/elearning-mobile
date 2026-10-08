import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_shared_preference.g.dart';

@riverpod
AppSharedPreference appSharedPreference(Ref ref) {
  return AppSharedPreference(SharedPreferencesAsync());
}

class AppSharedPreference {
  final SharedPreferencesAsync _prefs;

  AppSharedPreference(this._prefs);

  Future<void> setBool({required String key, required bool value}) async {
    return _prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    return _prefs.getBool(key);
  }
}
