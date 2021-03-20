import 'dart:io';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:intl/intl.dart';
import 'main_screen_controller.dart';

class AllHabitController extends GetxController {
  var listAllHabit = List<Habit>().obs;
  var listAnytimeHabit = List<Habit>().obs;
  var listMorningHabit = List<Habit>().obs;
  var listAfternoonHabit = List<Habit>().obs;
  var listEveningHabit = List<Habit>().obs;
  var flag = false.obs;

  var listHabitProcess = List<Process>().obs;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  MainScreenController mainScreenController = Get.put(MainScreenController());

  @override
  void onInit() {
    getAllHabit();
    //getHabitByWeekDate(DateTime.now().weekday + 1);
    super.onInit();
  }

  Future<void> getAllHabit() async {
    flag.value = false;
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
    getHabitByWeekDate(mainScreenController.selectedDay.value.weekday);
    flag.value = true;
  }

  void getHabitByWeekDate(int weekdate) async {
    listAnytimeHabit.clear();
    for (int i = 0; i < listAllHabit.length; i++) {
      if (listAllHabit[i].ngayTrongTuan.contains((weekdate + 1).toString())) {
        listAnytimeHabit.add(listAllHabit[i]);
      }
    }

    await getHabitProcess(mainScreenController.selectedDay.value);
    // nếu
    if (listHabitProcess.length != listAnytimeHabit.length) {
      // 2 cái không đồng bộ => thiếu process
      // => tạo
      for (int i = 0; i < listAnytimeHabit.length; i++) {
        DatabaseHelper.instance.insertProcess(
          listAnytimeHabit[i].ma,
          formatter.format(mainScreenController.selectedDay.value),
        );
      }
      // selecte lại
      await getHabitProcess(mainScreenController.selectedDay.value);
    }

    listMorningHabit.clear();
    listAfternoonHabit.clear();
    listEveningHabit.clear();
    for (int i = 0; i < listAnytimeHabit.length; i++) {
      if (listAnytimeHabit[i].buoi.contains('1'))
        listMorningHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].buoi.contains('2'))
        listAfternoonHabit.add(listAnytimeHabit[i]);

      if (listAnytimeHabit[i].buoi.contains('3'))
        listEveningHabit.add(listAnytimeHabit[i]);
    }
  }

  Future<void> getHabitProcess(DateTime date) async {
    listHabitProcess.clear();
    await DatabaseHelper.instance
        .selectHabitProcess(formatter.format(date))
        .then((value) {
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
    return listHabitProcess
        .firstWhere((element) => element.maThoiQuen == maThoiQuen);
  }

  Future<void> updateProcess(Process p) async {
    int index = listHabitProcess
        .indexWhere((element) => element.maThoiQuen == p.maThoiQuen);
    listHabitProcess[index] = p;
    //updateListView.value = true;
    await DatabaseHelper.instance.updateProcess(p);
  }

  Future<void> deleteHabit(Habit habit) async {
    await DatabaseHelper.instance.deleteHabit(habit.ma);
    await getAllHabit();
  }
}
