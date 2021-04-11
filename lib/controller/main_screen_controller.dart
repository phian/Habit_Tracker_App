import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';

class MainScreenController extends GetxController {
  var selectedDay = DateTime.now().obs;

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;
    }
  }

  int updateHabitProcess({int habitGoal, Habit habit}) {
    if (habit.batMucTieu == 0)
      return habit.soLan;
    else
      return -1;
  }
}
