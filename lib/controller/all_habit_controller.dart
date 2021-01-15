import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';

class AllHabitController extends GetxController {
  var listAllHabit = List<Habit>().obs;
  var listAnytimeHabit = List<Habit>().obs;
  var listMorningHabit = List<Habit>().obs;
  var listAfternoonHabit = List<Habit>().obs;
  var listEveningHabit = List<Habit>().obs;
  var title = "DO ANYTIME".obs;
  var selectedIndex = 0.obs;

  var listAnytimeWidgets = List<Widget>().obs;
  var listMorningWidgets = List<Widget>().obs;
  var listAfternoonWidgets = List<Widget>().obs;
  var listEveningWidgets = List<Widget>().obs;

  @override
  void onInit() {
    getAllHabit();
    super.onInit();
  }

  int getSelectedIndex() {
    return selectedIndex.value;
  }

  changeboxTite(int index) {
    if (index != selectedIndex.value) {
      selectedIndex.value = index;
      switch (index) {
        case 0:
          title.value = "DO ANYTIME";
          break;
        case 1:
          title.value = "MORNING";
          break;
        case 2:
          title.value = "AFTERNOON";
          break;
        case 3:
          title.value = "EVENING";
          break;
      }
    }
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
  }
}
