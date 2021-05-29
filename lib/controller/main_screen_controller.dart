import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:intl/intl.dart';
import 'utils/ultis.dart';

class MainScreenController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var listAllHabit = <Habit>[].obs;
  var listAnytimeHabit = <Habit>[].obs;
  var listMorningHabit = <Habit>[].obs;
  var listAfternoonHabit = <Habit>[].obs;
  var listEveningHabit = <Habit>[].obs;
  var isLoading = true.obs;

  /// Danh sách process theo ngày
  var listProcessByDay = <Process>[].obs;
  var appBarTitle = 'Today'.obs;

  // format appbar title
  final DateFormat appBarFormatter = DateFormat('MMMM, d');

  @override
  void onInit() {
    getAllHabit();
    super.onInit();
  }

  /// Set lại selectedDay và
  void changeSelectedDay(DateTime date) {
    if (selectedDate.value != date) {
      selectedDate.value = date;

      if (date.isToday()) {
        appBarTitle.value = 'Today';
      } else if (date.isTomorrow()) {
        appBarTitle.value = 'Tomorrow';
      } else if (date.isYesterday()) {
        appBarTitle.value = 'Yesterday';
      } else {
        appBarTitle.value = appBarFormatter.format(selectedDate.value);
      }
    }
  }

  /// Tìm ngày bắt đầu của tuần dựa vào 1 ngày xác định
  DateTime beginDateOfWeek(DateTime date) {
    // tuần bắt đầu bằng thứ 2 nên trừ 1
    return date.subtract(Duration(days: date.weekday - 1));
  }

  /// Tìm ngày cuối của tuần dựa vào 1 ngày xác định
  DateTime endDateOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  Future<void> getAllHabit() async {
    isLoading.value = true;

    listAllHabit.clear();
    listAllHabit.value = await DatabaseHelper.instance.getAllHabit();
    await getHabitByWeekDate(selectedDate.value.weekday);
    isLoading.value = false;
    print('get_all_habit');
  }

  Future<void> getHabitByWeekDate(int weekdate) async {
    listProcessByDay.value = await getListProcess(selectedDate.value);
    listAnytimeHabit.clear();
    listMorningHabit.clear();
    listAfternoonHabit.clear();
    listEveningHabit.clear();

    for (int i = 0; i < listAllHabit.length; i++) {
      int count;
      // duyệt các thói quen daily
      switch (listAllHabit[i].repeatMode) {
        case 0:
          if (listAllHabit[i].dayOfWeek.contains((weekdate + 1).toString())) {
            listAnytimeHabit.add(listAllHabit[i]);
          }
          break;

        case 1:
          // check nếu chưa đủ số lần thì thêm
          var begin = beginDateOfWeek(selectedDate.value);
          var end = endDateOfWeek(selectedDate.value);
          int count = await DatabaseHelper.instance.countProcessCompleteInRange(
            listAllHabit[i].habitId,
            begin,
            end,
          );
          int idx = listProcessByDay.indexWhere(
            (element) => element.habitId == listAllHabit[i].habitId,
          );

          bool isCompleted = false;
          if (idx != -1) {
            if (listProcessByDay[idx].result == listAllHabit[i].amount) {
              isCompleted = true;
            }
          }

          if (count < listAllHabit[i].timesPerWeek + 1 || isCompleted) {
            listAnytimeHabit.add(listAllHabit[i]);
          }

          break;

        case 2:
          // check nếu selectedday trùng thì thêm
          break;
      }
    }

    for (int i = 0; i < listAnytimeHabit.length; i++) {
      if (listAnytimeHabit[i].timeOfDay.contains('1')) listMorningHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('2')) listAfternoonHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('3')) listEveningHabit.add(listAnytimeHabit[i]);
    }
  }

  Future<List<Process>> getListProcess(DateTime date) async {
    try {
      return await DatabaseHelper.instance.getListProcess(date);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProcess(Process process) async {
    try {
      await DatabaseHelper.instance.updateProcess(process);
      listProcessByDay.value = await getListProcess(selectedDate.value);
    } catch (e) {
      throw e;
    }
  }

  Future<int> creatNewProcess({int habitId, DateTime date}) async {
    return await DatabaseHelper.instance.createNewProcess(habitId, date);
  }

  Future<void> deleteHabit(Habit habit) async {
    await DatabaseHelper.instance.deleteHabit(habit.habitId);
    await getAllHabit();
  }

  void updateFlagValue(bool value) {
    isLoading.value = value;
  }
}
