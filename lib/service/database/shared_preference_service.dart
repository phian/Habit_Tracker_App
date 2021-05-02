import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferenceService _sharedPreferences;

  static SharedPreferenceService get instance {
    if (_sharedPreferences == null) {
      _sharedPreferences = SharedPreferenceService();
      return _sharedPreferences;
    } else {
      return _sharedPreferences;
    }
  }

  Future<SharedPreferences> getPref() async {
    return await SharedPreferences.getInstance();
  }
}
