import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/view/view_subfile/habit_all_note_screen/date_divider.dart';
import 'package:habit_tracker/view/view_subfile/habit_all_note_screen/note_content_card.dart';

class HabitAllNoteScreenController extends GetxController {
  var habitId = 1.obs;
  var noteContentText = "".obs;

  var dateList = [].obs;
  var noteContent = [].obs;
  var dateListWidget = [].obs;
  var noteContentBoxes = [].obs;

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  updateHabitId(int data) {
    if (data != null) habitId.value = data;
  }

  void checkControllerState(
      HabitAllNoteScreenController controller, DatabaseHelper databaseHelper) {
    if (controller.isClosed) {
      controller = Get.put(HabitAllNoteScreenController());
      databaseHelper = DatabaseHelper.instance;
    }
  }

  void initData() async {}

  /// [Read date data]
  Future<Map<String, dynamic>> readDateData() async {
    return databaseHelper.readDataDataFromNoteTable().then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (checkIfDateDataExist(value[i]['ngay'].toString()) == false) {
            dateList.add(value[i]['ngay'].toString());
            dateListWidget.add(DateDivider(
              date: value[i]['ngay'].toString().replaceAll(' ', '/'),
            ));
          } else {
            dateList[i] = value[i]['ngay'].toString();
            dateListWidget[i] = DateDivider(
              date: value[i]['ngay'].toString().replaceAll(' ', '/'),
            );
          }
        }
      }
    }).catchError((err) => debugPrint(err.toString()));
  }

  /// [Read all note content]
  Future<Map<String, dynamic>> readAllNoteData({
    HabitAllNoteScreenController controller,
  }) async {
    return await databaseHelper.readAllNoteData().then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (checkIfContentExist(value[i]['noi_dung'].toString()) == false) {
            noteContent.add(value[i]['noi_dung'].toString());
            updateNoteContentData(value[i]['noi_dung'].toString());
            noteContentBoxes.add(NoteContentCard(
              content: noteContentText,
              controller: controller,
            ));
          } else {
            noteContent[i] = value[i]['noi_dung'].toString();
            updateNoteContentData(value[i]['noi_dung'].toString());
            noteContentBoxes[i] = NoteContentCard(
              content: noteContentText,
              controller: controller,
            );
          }
        }
        // print("Có vô đây");
      }
    }).catchError((err) => debugPrint(err.toString()));
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
