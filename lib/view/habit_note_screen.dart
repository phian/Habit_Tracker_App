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
  NoteScreenController _noteScreenController;
  TextEditingController _noteController;
  String _noteContent = "";

  @override
  void initState() {
    super.initState();

    _noteScreenController = Get.put(NoteScreenController());
    _noteScreenController.checkAndUpdateHabitId(Get.arguments);
    _noteScreenController.readDataForTextController().then((value) {
      _noteController = TextEditingController(
        text: _noteScreenController.initTextFieldData.value,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
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
      backgroundColor: AppColors.c0000,
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
        TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(50.0, 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            print("conteroller text: ${_noteController.text}");
            _noteScreenController.saveHabitNoteData(
              _noteContent,
            );
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
        onChanged: (value) {
          _noteContent = _noteController.text;
        },
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
