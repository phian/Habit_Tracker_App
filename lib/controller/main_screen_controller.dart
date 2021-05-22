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
  String firstDateOfWeek(DateTime date) {
    // tuần bắt đầu bằng thứ 2 nên trừ 1
    DateTime firstDate = date.subtract(Duration(days: date.weekday - 1));
    return AppConstants.dateFormatter.format(firstDate);
  }

  /// Tìm ngày cuối của tuần dựa vào 1 ngày xác định
  String lastDateOfWeek(DateTime date) {
    DateTime lastDate = date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    return AppConstants.dateFormatter.format(lastDate);
  }

  Future<void> getAllHabit() async {
    isLoading.value = true;

    listAllHabit.clear();
    listAllHabit.value = await DatabaseHelper.instance.getAllHabit();
    await getHabitByWeekDate(selectedDate.value.weekday);
    await getHabitProcessByDate(selectedDate.value);
    isLoading.value = false;
  }

  Future<void> getHabitByWeekDate(int weekdate) async {
    listAnytimeHabit.clear();
    for (int i = 0; i < listAllHabit.length; i++) {
      if (listAllHabit[i].dayOfWeek.contains((weekdate + 1).toString())) {
        listAnytimeHabit.add(listAllHabit[i]);
      }
    }

    listProcessByDay.value = await getHabitProcessByDate(selectedDate.value);

    listMorningHabit.clear();
    listAfternoonHabit.clear();
    listEveningHabit.clear();

    for (int i = 0; i < listAnytimeHabit.length; i++) {
      if (listAnytimeHabit[i].timeOfDay.contains('1')) listMorningHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('2')) listAfternoonHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].timeOfDay.contains('3')) listEveningHabit.add(listAnytimeHabit[i]);
    }
  }

  Future<List<Process>> getHabitProcessByDate(DateTime date) async {
    try {
      return await DatabaseHelper.instance.getListHabitProcessByDate(date);
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateProcess(Process process) async {
    try {
      await DatabaseHelper.instance.updateProcess(process);
      listProcessByDay.value = await getHabitProcessByDate(selectedDate.value);
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
