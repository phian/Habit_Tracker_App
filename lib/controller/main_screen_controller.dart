import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:intl/intl.dart';
import 'utils/ultis.dart';

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

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
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

  int updateHabitProcess({int habitGoal, Habit habit}) {
    if (habit.batMucTieu == 0)
      return habit.soLan;
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
    await DatabaseHelper.instance.selectAllHabit().then((value) {
      value.forEach((element) {
        listAllHabit.add(
          Habit(
            ma: element['ma'],
            ten: element['ten'],
            icon: element['icon'],
            mau: element['mau'],
            batMucTieu: element['bat_muc_tieu'],
            soLan: element['so_lan'],
            donVi: element['don_vi'],
            loaiLap: element['loai_lap'],
            ngayTrongTuan: element['ngay_trong_tuan'],
            soLanTrongTuan: element['so_lan_trong_tuan'],
            buoi: element['buoi'],
            trangThai: element['trang_thai'],
          ),
        );
      });
    });
    await getHabitByWeekDate(selectedDay.value.weekday);
    isLoading.value = false;
  }

  Future<void> getHabitByWeekDate(int weekdate) async {
    listAnytimeHabit.clear();

    for (int i = 0; i < listAllHabit.length; i++) {
      if (listAllHabit[i].ngayTrongTuan.contains((weekdate + 1).toString())) {
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
          listAnytimeHabit[i].ma,
          formatter.format(selectedDay.value),
        );
      }
      // selecte lại
      await getHabitProcess(selectedDay.value);
    }

    listMorningHabit.clear();
    listAfternoonHabit.clear();
    listEveningHabit.clear();
    for (int i = 0; i < listAnytimeHabit.length; i++) {
      if (listAnytimeHabit[i].buoi.contains('1')) listMorningHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].buoi.contains('2')) listAfternoonHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].buoi.contains('3')) listEveningHabit.add(listAnytimeHabit[i]);
    }
  }

  Future<void> getHabitProcess(DateTime date) async {
    listHabitProcess.clear();
    await DatabaseHelper.instance.selectHabitProcess(formatter.format(date)).then((value) {
      value.forEach((element) {
        listHabitProcess.add(Process(
          maThoiQuen: element['ma_thoi_quen'],
          ngay: element['ngay'],
          ketQua: element['ket_qua'],
          skip: element['skip'] == 1 ? true : false,
        ));
      });
    });
  }

  Process findProcess(int maThoiQuen) {
    return listHabitProcess.firstWhere((element) => element.maThoiQuen == maThoiQuen);
  }

  Future<void> updateProcess(Process p) async {
    int index = listHabitProcess.indexWhere((element) => element.maThoiQuen == p.maThoiQuen);
    listHabitProcess[index] = p;
    //updateListView.value = true;
    await DatabaseHelper.instance.updateProcess(p);
  }

  Future<void> deleteHabit(Habit habit) async {
    await DatabaseHelper.instance.deleteHabit(habit.ma);
    await getAllHabit();
  }

  void updateFlagValue(bool value) {
    isLoading.value = value;
  }
}
