import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';

class AllHabitController extends GetxController {
  var allHabit = List<Habit>().obs;

  void getAllHabit() {
    DatabaseHelper.instance.selectAllHabit().then((value) {
      value.forEach((element) {
        allHabit.add(
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
