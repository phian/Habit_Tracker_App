import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';
import 'package:habit_tracker/view/notification_screen.dart';

class NotificationController extends GetxController {
  var isHabitsOrChallenge = 1.obs;
  var todayPlanSwitch = true.obs;
  var morningPlanSwitch = false.obs;
  var afternoonPlanSwitch = false.obs;
  var eveningPlanSwitch = false.obs;
  var todayResultSwitch = true.obs;

  /// Challenge
  var challengeNotificationSwitch = true.obs;
  var challengeTodayPlanTime = "00:00".obs;
  var challengeProgressCheckUpTime = "00:00".obs;

  SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService.instance;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  /// [Habit notification]
  ///
  var todayPlanPickedTime = (TimeOfDay.now().hour.toString().padLeft(2, "0") +
          ":" +
          TimeOfDay.now().minute.toString().padLeft(2, "0"))
      .obs;
  var resultPickedTime = (TimeOfDay.now().hour.toString().padLeft(2, "0") +
          ":" +
          TimeOfDay.now().minute.toString().padLeft(2, "0"))
      .obs;

  NotificationController() {
    initData();
  }

  void initData() {
    initPickedTimeSwitchValue();
    initPlanSwitches();
    initSelectedTime();
  }

  void initSelectedTime() async {
    var pref = await _sharedPreferenceService.getPref();

    todayPlanPickedTime.value = pref.getString(AppConstants.todayPlanKey) ??
        TimeOfDay.now().hour.toString().padLeft(2, "0") +
            ":" +
            TimeOfDay.now().minute.toString().padLeft(2, "0");

    resultPickedTime.value = pref.getString(AppConstants.todayResultKey) ??
        TimeOfDay.now().hour.toString().padLeft(2, "0") +
            ":" +
            TimeOfDay.now().minute.toString().padLeft(2, "0");
  }

  void initPlanSwitches() async {
    var pref = await _sharedPreferenceService.getPref();

    if (pref.getBool(AppConstants.morningPlanKey) != null) {
      morningPlanSwitch.value = pref.getBool(AppConstants.morningPlanKey);
    }
    if (pref.getBool(AppConstants.afternoonPlanKey) != null) {
      afternoonPlanSwitch.value = pref.getBool(AppConstants.afternoonPlanKey);
    }
    if (pref.getBool(AppConstants.eveningPlanKey) != null) {
      eveningPlanSwitch.value = pref.getBool(AppConstants.eveningPlanKey);
    }
  }

  void initPickedTimeSwitchValue() async {
    var pref = await _sharedPreferenceService.getPref();
    var todayPlanResult = pref.getBool(AppConstants.todayPlanSwitchKey);

    if (todayPlanResult != null) {
      todayPlanSwitch.value = pref.getBool(AppConstants.todayPlanSwitchKey);
    }

    var todayResult = pref.getBool(AppConstants.todayPlanSwitchKey);
    if (todayResult != null) {
      todayResultSwitch.value = pref.getBool(AppConstants.todayResultSwitchKey);
    }
  }

  changeIsHabitsOrChallenge(int index) {
    if (isHabitsOrChallenge.value != index) {
      isHabitsOrChallenge.value = index;
    }
  }

  void changePickedTime(PickedTimeType type, TimeOfDay result) async {
    switch (type) {
      case PickedTimeType.todayPlan:
        todayPlanPickedTime.value =
            "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";

        savePickedTimeValue(
          AppConstants.todayPlanKey,
          todayPlanPickedTime.value,
        );
        break;
      case PickedTimeType.todayResult:
        resultPickedTime.value =
            "${result.hour.toString().padLeft(2, '0')}:${result.minute.toString().padLeft(2, '0')}";

        savePickedTimeValue(
          AppConstants.todayResultKey,
          resultPickedTime.value,
        );
        break;
    }
  }

  void savePickedTimeValue(String key, String value) async {
    var pref = await _sharedPreferenceService.getPref();
    pref.setString(key, value);
  }

  ///
  void onDateTimeNotificationSwitchPress(PickedTimeType type) async {
    var pref = await _sharedPreferenceService.getPref();

    switch (type) {
      case PickedTimeType.todayPlan:
        todayPlanSwitch.value = !todayPlanSwitch.value;

        pref.setBool(AppConstants.todayPlanSwitchKey, todayPlanSwitch.value);

        // saveTodayPlanOrResultSwitchValue(
        //   AppConstants.todayPlanSwitchKey,
        //   todayPlanSwitch.value,
        // );
        break;
      case PickedTimeType.todayResult:
        todayResultSwitch.value = !todayResultSwitch.value;
        pref.setBool(
            AppConstants.todayResultSwitchKey, todayResultSwitch.value);

        // saveTodayPlanOrResultSwitchValue(
        //   AppConstants.todayResultSwitchKey,
        //   todayResultSwitch.value,
        // );
        break;
    }
  }

  void saveTodayPlanOrResultSwitchValue(String key, bool value) async {
    var pref = await _sharedPreferenceService.getPref();
    pref.setBool(key, value);
  }

  /// [Challenge notification]
  ///
  changeChallengeSwitchValue() {
    challengeNotificationSwitch.value = !challengeNotificationSwitch.value;
  }

  changeChallengeTodayPlanTime(TimeOfDay time) {
    String temp = time.hour.toString() +
        ":" +
        ((time.minute < 10)
            ? ("0" + time.minute.toString())
            : time.minute.toString());
    if (challengeTodayPlanTime.value != temp) {
      challengeTodayPlanTime.value = temp;
    }
  }

  changeProgressCheckUpTime(TimeOfDay time) {
    String temp = time.hour.toString() +
        ":" +
        ((time.minute < 10)
            ? ("0" + time.minute.toString())
            : time.minute.toString());
    if (challengeProgressCheckUpTime.value != temp) {
      challengeProgressCheckUpTime.value = temp;
    }
  }

  void onNoneDateTimeNotificationSwitchPress(NotificationPlanType type) async {
    var pref = await _sharedPreferenceService.getPref();

    switch (type) {
      case NotificationPlanType.morning:
        morningPlanSwitch.value = !morningPlanSwitch.value;

        pref.setBool(AppConstants.morningPlanKey, morningPlanSwitch.value);
        break;
      case NotificationPlanType.afternoon:
        afternoonPlanSwitch.value = !afternoonPlanSwitch.value;

        pref.setBool(AppConstants.afternoonPlanKey, afternoonPlanSwitch.value);
        break;
      case NotificationPlanType.evening:
        eveningPlanSwitch.value = !eveningPlanSwitch.value;

        pref.setBool(AppConstants.eveningPlanKey, eveningPlanSwitch.value);
        break;
    }
  }

  void saveDateTimePlanNotificationValue(String key, bool value) async {
    var pref = await _sharedPreferenceService.getPref();
    pref.setBool(key, value);
  }
}
