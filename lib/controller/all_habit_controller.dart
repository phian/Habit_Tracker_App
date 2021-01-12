import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';

class AllHabitController extends GetxController {
  var listAllHabit = List<Habit>().obs;

  @override
  void onInit() {
    getAllHabit();
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
  }
}
