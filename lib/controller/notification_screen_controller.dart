import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  changeIsHabitsOrChallenge(RxInt index) {
    if (isHabitsOrChallenge.value != index.value) {
      isHabitsOrChallenge.value = index.value;
    }
  }

  changeIsOnOrOffTodayPlanOrResultNoti(int index) {
    index == 0
        ? isOnOrOffTodayPlanNoti.value = !isOnOrOffTodayPlanNoti.value
        : isOnOrOffTodayResult.value = !isOnOrOffTodayResult.value;
  }

  changeIsOnOrOffDAteTimePlanNoti(int index) {
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

  changePickedtime(int index, TimeOfDay timeOfDay) {
    index == 0
        ? todayPlanPickedTime.value = (timeOfDay.hour.toString() +
            ":" +
            (timeOfDay.minute < 10 ? "0" : "") +
            timeOfDay.minute.toString())
        : resultNotiPickedTime.value = (timeOfDay.hour.toString() +
            ":" +
            (timeOfDay.minute < 10 ? "0" : "") +
            timeOfDay.minute.toString());
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

  void onChallengeNotificationTilePress(
      {BuildContext context, String title}) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        if (title.toLowerCase() == "plan for today") {
          changeChallengeTodayPlanTime(value);
        } else {
          changeProgressCheckUpTime(value);
        }
      }
    });
  }

  void onHabitNotificationTilePress(
      {BuildContext context, IconData icon}) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (icon == Icons.assignment)
        changePickedtime(0, value);
      else
        changePickedtime(1, value);
    });
  }

  void onNoneDateTimeNotificationSwitchPress({IconData icon}) {
    if (icon == Icons.wb_sunny) {
      changeIsOnOrOffDAteTimePlanNoti(0);
    } else if (Icons.cloud == icon) {
      changeIsOnOrOffDAteTimePlanNoti(1);
    } else {
      changeIsOnOrOffDAteTimePlanNoti(2);
    }
  }

  void onDateTimeNotificationSwitchPress({IconData icon}) {
    if (icon == Icons.assignment)
      changeIsOnOrOffTodayPlanOrResultNoti(0);
    else
      changeIsOnOrOffTodayPlanOrResultNoti(1);
  }
}
