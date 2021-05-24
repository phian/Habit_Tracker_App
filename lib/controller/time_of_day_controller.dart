import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';
import 'package:habit_tracker/view/time_of_day_screen.dart';

class TimeOfDayController extends GetxController {
  var morningStartTime = "00:00".obs;
  var afternoonStartTime = "".obs;
  var eveningStartTime = "".obs;

  SharedPreferenceService _preferenceService = SharedPreferenceService.instance;

  void saveTimeData(TimeType type, String value) async {
    var pref = await _preferenceService.getPref();

    switch (type) {
      case TimeType.morning:
        pref.setString(AppConstants.morningStartTimeKey, value);
        initStartTime();
        break;
      case TimeType.afternoon:
        pref.setString(AppConstants.afternoonStartTimeKey, value);
        initStartTime();
        break;
      case TimeType.evening:
        pref.setString(AppConstants.eveningStartTimeKey, value);
        initStartTime();
        break;
    }
  }

  void initStartTime() async {
    var pref = await _preferenceService.getPref();

    if (pref.getString(
          AppConstants.morningStartTimeKey,
        ) ==
        null) {
      pref.setString(AppConstants.morningStartTimeKey, "00:00");
      morningStartTime.value = pref.getString(
        AppConstants.morningStartTimeKey,
      );
    } else {
      morningStartTime.value = pref.getString(
        AppConstants.morningStartTimeKey,
      );
    }

    if (pref.getString(AppConstants.afternoonStartTimeKey) == null) {
      pref.setString(AppConstants.afternoonStartTimeKey, "12:00");
      afternoonStartTime.value = pref.getString(
        AppConstants.afternoonStartTimeKey,
      );
    } else {
      afternoonStartTime.value = pref.getString(
        AppConstants.afternoonStartTimeKey,
      );
    }

    if (pref.getString(AppConstants.eveningStartTimeKey) == null) {
      pref.setString(AppConstants.eveningStartTimeKey, "17:00");
      eveningStartTime.value = pref.getString(
        AppConstants.eveningStartTimeKey,
      );
    } else {
      eveningStartTime.value = pref.getString(
        AppConstants.eveningStartTimeKey,
      );
    }
  }
}
