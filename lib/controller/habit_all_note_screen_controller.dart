import 'package:get/get.dart';

class HabitAllNoteScreenController extends GetxController {
  var habitId = 1.obs;
  var noteContentText = "".obs;

  var dateList = [].obs;
  var noteContent = [].obs;
  var dateListWidget = [].obs;
  var noteContentBoxes = [].obs;

  updateHabitId(int data) {
    habitId.value = data;
  }

  bool checkIfDateDataExist(String date) {
    if (dateList.contains(date)) {
      return true;
    }
    return false;
  }

  bool checkIfContentExist(String content) {
    if (noteContent.contains(content)) {
      return true;
    }
    return false;
  }

  updateNoteContentData(String data) {
    noteContentText.value = data;
  }
}
