import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:intl/intl.dart';

class NoteScreenController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  bool isCreatedNote = false;

  Future<String> getNoteContent(int habitId, DateTime date) async {
    var diarys = await databaseHelper.getNote(habitId, date);
    isCreatedNote = diarys.length > 0 ? true : false;
    return isCreatedNote ? diarys[0].content : "";
  }

  Future<void> saveNote(int habitId, DateTime date, String noteContent) async {
    if (isCreatedNote) {
      databaseHelper.updateHabitNoteData(Diary(
        habitId: habitId,
        date: DateFormat('yyyy-MM-dd').format(date),
        content: noteContent,
      ));
    } else {
      databaseHelper.insertHabitNote(Diary(
        habitId: habitId,
        date: DateFormat('yyyy-MM-dd').format(date),
        content: noteContent,
      ));
    }
  }
}
