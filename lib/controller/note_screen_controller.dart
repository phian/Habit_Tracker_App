import 'package:get/get.dart';

class NoteScreenController extends GetxController {
  var habitId = 1.obs;
  var initTextFieldData = "".obs;

  updateHabitId(int id) {
    habitId.value = id;
  }
}
