import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:habit_tracker/service/database/database_helper.dart';


class NoteScreenController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
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
        date: AppConstants.dateFormatter.format(date),
        content: noteContent,
      ));
    } else {
      databaseHelper.insertHabitNote(Diary(
        habitId: habitId,
        date: AppConstants.dateFormatter.format(date),
        content: noteContent,
      ));
    }
  }
}
