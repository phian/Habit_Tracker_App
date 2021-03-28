import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/view/habit_note_screen.dart';
import 'package:habit_tracker/view/habit_statistic_screen.dart';

class MainScreenController extends GetxController with SideMenuModel {
  var selectedDay = DateTime.now().obs;

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;
    }
  }

  void moveToHabitStatisticScreen(Habit habit) {
    Get.to(
      HabitStatisticScreen(),
      arguments: habit,
      transition: Transition.fadeIn,
    );
  }

  void moveToHabitNoteScreen(Habit habit) {
    Get.to(
      HabitNoteScreen(),
      arguments: habit.ma,
      transition: Transition.fadeIn,
    );
  }

  int updateHabitProcess({int habitGoal, Habit habit}) {
    if (habit.batMucTieu == 0)
      return habit.soLan;
    else
      return -1;
  }
}
