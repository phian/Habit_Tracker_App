import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

class NotificationController extends GetxController {
  var isHabitsOrChallenge = 1.obs;
  var isOnOrOffTodayPlanNoti = true.obs;
  var isOnOrOffMorningPlan = false.obs;
  var isOnOrOffAternoonPlan = false.obs;
  var isOnOrOffEveningPlan = false.obs;
  var isOnOrOffTodayResult = true.obs;

  /// [Challenge]
  var isOnChallengeNoti = true.obs;
  var challengeTodayPlanTime = "00:00".obs;
  var challengeProgressCheckUpTime = "00:00".obs;

  SharedPreferenceService _sharedPreferenceService =
      SharedPreferenceService.instance;

  /// [Habit notification]
  ///
  var todayPlanPickedTime = (TimeOfDay.now().hour.toString() +
          ":" +
          (TimeOfDay.now().minute < 10 ? "0" : "") +
          TimeOfDay.now().minute.toString())
      .obs;

  var resultNotiPickedTime = (TimeOfDay.now().hour.toString() +
          ":" +
          (TimeOfDay.now().minute < 10 ? "0" : "") +
          TimeOfDay.now().minute.toString())
      .obs;

  changeIsHabitsOrChallenge(int index) {
    if (isHabitsOrChallenge.value != index) {
      isHabitsOrChallenge.value = index;
    }
  }

  changeIsOnOrOffTodayPlanOrResultNoti(int index) {
    index == 0
        ? isOnOrOffTodayPlanNoti.value = !isOnOrOffTodayPlanNoti.value
        : isOnOrOffTodayResult.value = !isOnOrOffTodayResult.value;
  }

  changeIsOnOrOffDAteTimePlanNotice(int index) {
    switch (index) {
      case 0:
        isOnOrOffMorningPlan.value = !isOnOrOffMorningPlan.value;
        break;
      case 1:
        isOnOrOffAternoonPlan.value = !isOnOrOffAternoonPlan.value;
        break;
      case 2:
        isOnOrOffEveningPlan.value = !isOnOrOffEveningPlan.value;
        break;
    }
  }

  changePickedTime(int index, TimeOfDay timeOfDay) async {
    var pref = await _sharedPreferenceService.getPref();
    switch (index) {
      case 0:
        todayPlanPickedTime.value = (timeOfDay.hour.toString().padLeft(2, '0') +
            ":" +
            timeOfDay.minute.toString().padLeft(2, '0'));
        pref.setString(
          "today_plan_reminder_time",
          todayPlanPickedTime.value,
        );
        break;
      case 1:
        resultNotiPickedTime.value =
            (timeOfDay.hour.toString().padLeft(2, '0') +
                ":" +
                timeOfDay.minute.toString().padLeft(2, '0'));
        pref.setString(
          "today_result_reminder_time",
          resultNotiPickedTime.value,
        );
        break;
    }
  }

  /// [Challenge notification]
  ///
  changeIsOnChallengeNoti() {
    isOnChallengeNoti.value = !isOnChallengeNoti.value;
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

  void onNoneDateTimeNotificationSwitchPress(IconData icon) {
    if (icon == Icons.wb_sunny) {
      changeIsOnOrOffDAteTimePlanNotice(0);
    } else if (Icons.cloud == icon) {
      changeIsOnOrOffDAteTimePlanNotice(1);
    } else {
      changeIsOnOrOffDAteTimePlanNotice(2);
    }
  }

  void onDateTimeNotificationSwitchPress(IconData icon) {
    if (icon == Icons.assignment)
      changeIsOnOrOffTodayPlanOrResultNoti(0);
    else
      changeIsOnOrOffTodayPlanOrResultNoti(1);
  }
}
