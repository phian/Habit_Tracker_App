import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static SharedPreferenceService _sharedPreferences;

  SharedPreferenceService._();

  static SharedPreferenceService get instance {
    if (_sharedPreferences == null) {
      _sharedPreferences = SharedPreferenceService._();
      return _sharedPreferences;
    }
    return _sharedPreferences;
  }

  Future<SharedPreferences> getPref() async {
    return await SharedPreferences.getInstance();
  }
}
