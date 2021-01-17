import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/note_screen_controller.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:intl/intl.dart';

class HabitNoteScreen extends StatefulWidget {
  HabitNoteScreen({Key key}) : super(key: key);

  @override
  _HabitNoteScreenState createState() => _HabitNoteScreenState();
}

class _HabitNoteScreenState extends State<HabitNoteScreen> {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  TextEditingController _noteController = TextEditingController();

  NoteScreenController _noteScreenController = Get.put(NoteScreenController());

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null)
      _noteScreenController.updateHabitId(Get.arguments);
    _readDataForTextController();

    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitNoteScreenAppBar(),
      body: Obx(
        () =>
            _habitNoteScreenBody(_noteScreenController.initTextFieldData.value),
      ),
    );
  }

  /// [Hàm đọc data khởi tạo cho controller]
  _readDataForTextController() async {
    await _databaseHelper
        .selectHabitNote(_noteScreenController.habitId.value)
        .then((value) {
      if (value.length != 0) {
        _noteScreenController.initTextFieldData.value = value[0]['noi_dung'];
        _noteController = TextEditingController(text: value[0]['noi_dung']);
        print(_noteScreenController.initTextFieldData.value);
      }
    });
  }

  /// [Hàm đọc data cho note (nếu có)]
  _saveHabitNoteData() async {
    await _databaseHelper
        .selectHabitNote(_noteScreenController.habitId.value)
        .then((value) {
      if (value.length == 0) {
        _databaseHelper.insertHabitNote(
          Diary(
            maThoiQuen: _noteScreenController.habitId.value,
            ngay: DateFormat("dd MM yyyy").format(
              DateTime.now(),
            ),
            noiDung: _noteController.text,
          ),
        );
        Get.back();
        return;
      } else {
        /// [Xét trường hợp nếu ng dùng sửa các noter cũ]
        for (int i = 0; i < value.length - 1; i++) {
          _databaseHelper.updateHabitNoteData(
            Diary(
              maThoiQuen: _noteScreenController.habitId.value,
              ngay: value[i]['ngay'],
              noiDung: _noteController.text,
            ),
          );
          Get.back();
        }

        /// [Xét trường hợp cho note gần nhất]
        if (value[value.length - 1]['ngay'] ==
            DateFormat("dd MM yyyy").format(
              DateTime.now(),
            )) {
          _databaseHelper.updateHabitNoteData(
            Diary(
              maThoiQuen: _noteScreenController.habitId.value,
              ngay: DateFormat("dd MM yyyy").format(
                DateTime.now(),
              ),
              noiDung: _noteController.text,
            ),
          );
          Get.back();
        } else if (value[value.length - 1]['ngay'] !=
            DateFormat("dd MM yyyy").format(
              DateTime.now(),
            )) {
          _databaseHelper.insertHabitNote(
            Diary(
              maThoiQuen: _noteScreenController.habitId.value,
              ngay: DateFormat("dd MM yyyy").format(
                DateTime.now(),
              ),
              noiDung: _noteController.text,
            ),
          );
          Get.back();
        }
      }
    });
  }

  /// [App Bar]
  Widget _habitNoteScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
      title: Text(
        "Add note",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        FlatButton(
          minWidth: 50.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          onPressed: () {
            _saveHabitNoteData();
          },
          child: Text(
            "Done",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  /// [Body]
  Widget _habitNoteScreenBody(String value) {
    return Container(
      height: Get.height,
      child: TextField(
        autofocus: true,
        scrollPhysics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        controller: _noteController,
        maxLines: Get.height.toInt(),
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: 22.0),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
