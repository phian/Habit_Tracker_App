import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/utils/ultis.dart';
import 'package:intl/intl.dart';

class MainScreenController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var listAllHabit = <Habit>[].obs;
  var listAnytimeHabit = <Habit>[].obs;
  var listMorningHabit = <Habit>[].obs;
  var listAfternoonHabit = <Habit>[].obs;
  var listEveningHabit = <Habit>[].obs;
  var isLoading = true.obs;
  var listHabitProcess = <Process>[].obs;
  var appBarTitle = 'Today'.obs;

  // format appbar title
  final DateFormat appBarFormatter = DateFormat('MMMM, d');

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;

      if (date.isToday()) {
        appBarTitle.value = 'Today';
      } else if (date.isTomorrow()) {
        appBarTitle.value = 'Tomorrow';
      } else if (date.isYesterday()) {
        appBarTitle.value = 'Yesterday';
      } else {
        appBarTitle.value = appBarFormatter.format(selectedDay.value);
      }
    }
  }

  int updateHabitProcess({Habit habit}) {
    if (habit.isSetGoal)
      return habit.amount;
    else
      return -1;
  }

  @override
  void onInit() {
    getAllHabit();
    super.onInit();
  }

  Future<void> getAllHabit() async {
    isLoading.value = true;

    listAllHabit.clear();

    listAllHabit.value = await DatabaseHelper.instance.getAllHabit();

    await getHabitByWeekDate(selectedDay.value.weekday);

    isLoading.value = false;
  }

  Future<void> getHabitByWeekDate(int weekdate) async {
    listAnytimeHabit.clear();

    for (int i = 0; i < listAllHabit.length; i++) {
      if (listAllHabit[i].dayOfWeek.contains((weekdate + 1).toString())) {
        listAnytimeHabit.add(listAllHabit[i]);
      }
    }

    await getHabitProcess(selectedDay.value);
    // nếu
    if (listHabitProcess.length != listAnytimeHabit.length) {
      // 2 cái không đồng bộ => thiếu process
      // => tạo
      for (int i = 0; i < listAnytimeHabit.length; i++) {
        await DatabaseHelper.instance.insertProcess(
          listAnytimeHabit[i].habitId,
          selectedDay.value,
        );
      }
      // selecte lại
      await getHabitProcess(selectedDay.value);
    }

    listMorningHabit.clear();
    listAfternoonHabit.clear();
    listEveningHabit.clear();
    for (int i = 0; i < listAnytimeHabit.length; i++) {
      if (listAnytimeHabit[i].timeOfDay.contains('1')) listMorningHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('2')) listAfternoonHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('3')) listEveningHabit.add(listAnytimeHabit[i]);
    }
  }

  Future<void> getHabitProcess(DateTime date) async {
    listHabitProcess.clear();
    listHabitProcess.value = await DatabaseHelper.instance.getListHabitProcessByDate(date);
  }

  Process findProcess(int maThoiQuen) {
    return listHabitProcess.firstWhere((element) => element.habitId == maThoiQuen);
  }

  Future<void> updateProcess(Process p) async {
    int index = listHabitProcess.indexWhere((element) => element.habitId == p.habitId);
    listHabitProcess[index] = p;
    //updateListView.value = true;
    await DatabaseHelper.instance.updateProcess(p);
  }

  Future<void> deleteHabit(Habit habit) async {
    await DatabaseHelper.instance.deleteHabit(habit.habitId);
    await getAllHabit();
  }

  void updateFlagValue(bool value) {
    isLoading.value = value;
  }
}
