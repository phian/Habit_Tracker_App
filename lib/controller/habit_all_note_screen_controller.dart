import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/view/habit_all_note_screen/date_divider.dart';
import 'package:habit_tracker/view/habit_all_note_screen/note_content_card.dart';

class HabitAllNoteScreenController extends GetxController {
  var habitId = 1.obs;
  var noteContentText = "".obs;
  var loadingState = AllNoteLoadingState.isLoading.obs;

  var dateList = [].obs;
  var noteContent = [].obs;
  var dateListWidget = [].obs;
  var noteContentBoxes = [].obs;

  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  updateHabitId(int data) {
    if (data != null) habitId.value = data;
  }

  void initData() async {}

  /// [Read date data]
  Future<Map<String, dynamic>> readDateData() async {
    return databaseHelper
        .readDateDataFromNoteTable(habitId.value)
        .then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (checkIfDateDataExist(value[i]['ngay'].toString()) == false) {
            dateList.add(value[i]['ngay'].toString());
            dateListWidget.add(
              DateDivider(
                date: value[i]['ngay'].toString().replaceAll(' ', '/'),
              ),
            );
          } else {
            dateList[i] = value[i]['ngay'].toString();
            dateListWidget[i] = DateDivider(
              date: value[i]['ngay'].toString().replaceAll(' ', '/'),
            );
          }
        }
        loadingState.value = AllNoteLoadingState.isLoaded;
      } else {
        loadingState.value = AllNoteLoadingState.noDataAvailable;
      }
    }).catchError((err) => debugPrint(err.toString()));
  }

  /// [Read all note content]
  Future<Map<String, dynamic>> readAllNoteData() async {
    return databaseHelper.readAllNoteData(habitId.value).then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (checkIfContentExist(value[i]['noi_dung'].toString()) == false) {
            noteContent.add(value[i]['noi_dung'].toString());
            noteContentText.value = value[i]['noi_dung'].toString();
            noteContentBoxes.add(NoteContentCard(
              content: noteContentText,
              controller: this,
            ));
          } else {
            noteContent[i] = value[i]['noi_dung'].toString();
            noteContentText.value = value[i]['noi_dung'].toString();
            noteContentBoxes[i] = NoteContentCard(
              content: noteContentText,
              controller: this,
            );
          }
        }
        loadingState.value = AllNoteLoadingState.isLoaded;
        // print("Có vô đây");
      } else {
        loadingState.value = AllNoteLoadingState.noDataAvailable;
      }
    }).catchError((err) => throw err);
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
}
