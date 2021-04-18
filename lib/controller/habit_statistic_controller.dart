import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';

class HabitStatisticController extends GetxController {
  
  var habit = Habit().obs;

  var habitId = 1.obs;
  var habitIcon = Icons.star.obs;
  var iconColor = "F53566".obs;
  var habitName = "Habit name".obs;
  var finishedAmount = 0.obs;
  var goalAmount = 1.obs;
  var goalUnitType = "times".obs;
  var repeatType = "Daily".obs;
  var remindTime = "Set time".obs;
  var currentStreak = "0".obs;
  var longestStreak = "0".obs;
  var completeRate = "0".obs;
  var totalTimeComplete = "0".obs;

  var isResumeHabit = true.obs;

  backUpHabit(Habit habit) {
    this.habit.value = habit;
  }

  updateHabitStatisticInfo({
    int habitId,
    IconData icon,
    String iconColor,
    String habitName,
    String finishedAmount,
    int goalAmount,
    String goalUnitType,
    int repeatType,
    String remindTime,
    String currentStreak,
    String longestStreak,
    String completeRate,
    String totalTimeComplete,
  }) {
    this.habitId.value = habitId == null ? this.habitId.value : habitId;
    this.habitIcon.value = icon == null ? this.habitIcon.value : icon;
    this.iconColor.value = iconColor == null ? this.iconColor.value : iconColor;
    this.habitName.value = habitName == null ? this.habitName.value : habitName;
    this.finishedAmount.value =
        finishedAmount == null ? this.finishedAmount.value : finishedAmount;
    this.goalAmount.value =
        goalAmount == null ? this.goalAmount.value : goalAmount;
    this.goalUnitType.value =
        goalUnitType == null ? this.goalUnitType.value : goalUnitType;

    if (repeatType != null) {
      switch (repeatType) {
        case 0:
          this.repeatType.value = "Daily";
          break;
        case 1:
          this.repeatType.value = "Weekly";
          break;
        default:
          this.repeatType.value = "Monthly";
      }
    } else {
      this.repeatType.value = this.repeatType.value;
    }

    this.remindTime.value =
        remindTime == null ? this.remindTime.value : remindTime;
    this.currentStreak.value =
        currentStreak == null ? this.currentStreak.value : currentStreak;
    this.longestStreak.value =
        longestStreak == null ? this.longestStreak.value : longestStreak;
    this.completeRate.value =
        completeRate == null ? this.completeRate.value : completeRate;
    this.totalTimeComplete.value = totalTimeComplete == null
        ? this.totalTimeComplete.value
        : totalTimeComplete;
  }

  changeIsResumeHabit() {
    isResumeHabit.value = !isResumeHabit.value;
  }
}
