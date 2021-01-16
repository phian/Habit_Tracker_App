import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';

import 'main_screen_controller.dart';
import 'main_screen_controller.dart';

class AllHabitController extends GetxController {
  var listAllHabit = List<Habit>().obs;
  var listAnytimeHabit = List<Habit>().obs;
  var listMorningHabit = List<Habit>().obs;
  var listAfternoonHabit = List<Habit>().obs;
  var listEveningHabit = List<Habit>().obs;

  MainScreenController mainScreenController = Get.put(MainScreenController());

  @override
  void onInit() {
    getAllHabit();
    //getHabitByWeekDate(DateTime.now().weekday + 1);
    super.onInit();
  }

  void getAllHabit() async {
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
  }

  void getHabitByWeekDate(int weekdate) {
    listAnytimeHabit.clear();
    for (int i = 0; i < listAllHabit.length; i++) {
      if (listAllHabit[i].ngayTrongTuan.contains((weekdate + 1).toString())) {
        listAnytimeHabit.add(listAllHabit[i]);
      }
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
}
