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
  NoteScreenController _noteScreenController;

  @override
  void initState() {
    super.initState();

    _noteScreenController = Get.put(NoteScreenController());
    _noteScreenController.checkAndUpdateHabitId(Get.arguments);
    _noteScreenController.readDataForTextController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitNoteScreenAppBar(),
      body: Obx(
        () =>
            _habitNoteScreenBody(_noteScreenController.initTextFieldData.value),
      ),
    );
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
          onPressed: () => _noteScreenController.saveHabitNoteData(),
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
        controller: _noteScreenController.noteController,
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
