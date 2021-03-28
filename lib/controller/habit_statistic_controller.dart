import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/view/edit_habit_screen.dart';
import 'package:habit_tracker/view/habit_all_note_screen.dart';

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

  bool onBackButtonPress() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        Get.back();
      },
    );

    return true;
  }

  /// [Pause dialog]
  void onPopMenuPauseItemPress(BuildContext context) {
    if (isResumeHabit.value) {
      showPauseDialog(context);
    } else {
      changeIsResumeHabit();
    }
  }

  showPauseDialog(BuildContext context) async {
    Dialog pauseDialog = Dialog(
      backgroundColor: Color(0xFF2F313E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Paused a habit? It's still on your schedule and can be resued when you're ready",
                style: TextStyle(
                  color: Color(0xFFA7AAB1),
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () => onPauseItemButtonPressed(),
                child: Text(
                  'Got it',
                  style: TextStyle(color: Color(0xFF1C8EFE), fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => pauseDialog,
    );
  }

  void onPauseItemButtonPressed() {
    changeIsResumeHabit();
    Get.back();
  }

  /// [Delete dialog]
  showDeleteDialog(
      BuildContext context, AllHabitController allHabitController) async {
    Dialog deleteDialog = Dialog(
      backgroundColor: Color(0xFF2F313E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.7,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.2 * 0.1),
              child: Text(
                "Delete habit?",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: ListTile(
                onTap: () => onDeleteHabitButtonPressed(allHabitController),
                leading: Icon(
                  Icons.restore_outlined,
                  size: 20.0,
                  color: Color(0xFFFE7352),
                ),
                title: Text(
                  "Clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 1.0,
              color: Color(0xFF1E212A),
            ),
            Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                onTap: () => onDeleteHabitButtonPressed(allHabitController),
                leading: Icon(
                  Icons.auto_delete,
                  size: 20.0,
                  color: Color(0xFFF53566),
                ),
                title: Text(
                  "Delete habit and clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => deleteDialog,
    );
  }

  void onDeleteHabitButtonPressed(AllHabitController allHabitController) {
    allHabitController.deleteHabit(habit.value);
    Get.back();
  }

  /// [Move to habit all note screen]
  void moveToHabitAllNoteScreen() {
    Get.back();
    Get.to(
      HabitAllNoteScreen(),
      transition: Transition.fadeIn,
      arguments: habit.value.ma,
    );
  }

  /// [Move to edit habit screen]
  void moveToEditHabitScreen() {
    Get.back();
    Get.to(
      EditHabitScreen(),
      arguments: habit.value,
      transition: Transition.fadeIn,
    );
  }
}
