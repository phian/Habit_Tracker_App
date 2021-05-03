import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/note_screen_controller.dart';

class HabitNoteScreen extends StatefulWidget {
  HabitNoteScreen({Key key}) : super(key: key);

  @override
  _HabitNoteScreenState createState() => _HabitNoteScreenState();
}

class _HabitNoteScreenState extends State<HabitNoteScreen> {
  NoteScreenController noteScreenController;
  var noteController = TextEditingController();
  int habitId;
  DateTime date;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    noteScreenController = Get.put(NoteScreenController());
    habitId = Get.arguments[0];
    date = Get.arguments[1];
    var content = await noteScreenController.getNoteContent(habitId, date);
    noteController.text = content;
    // cho con trỏ về cuối text
    noteController.selection = TextSelection.collapsed(offset: noteController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      appBar: habitNoteScreenAppBar(),
      body: habitNoteScreenBody(),
    );
  }

  /// [App Bar]
  Widget habitNoteScreenAppBar() {
    return AppBar(
      backgroundColor: AppColors.c0000,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          noteScreenController.saveNote(
            habitId,
            date,
            noteController.text,
          );
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
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(50.0, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            print("controller text: ${noteController.text}");
            noteScreenController.saveNote(
              habitId,
              date,
              noteController.text,
            );
            Get.back();
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
  Widget habitNoteScreenBody() {
    return Container(
      height: Get.height,
      child: TextField(
        autofocus: true,
        scrollPhysics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        controller: noteController,
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
