import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var isIgnorePointer = false.obs;

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;
    }
  }

  chageIsIgnorePointer(bool isIgnore) {
    isIgnorePointer.value = isIgnore;
  }
}
