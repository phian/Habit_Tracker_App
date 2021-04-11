import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/habit_all_note_screen_controller.dart';

class HabitAllNoteScreen extends StatefulWidget {
  HabitAllNoteScreen({Key key}) : super(key: key);

  @override
  _HabitAllNoteScreenState createState() => _HabitAllNoteScreenState();
}

class _HabitAllNoteScreenState extends State<HabitAllNoteScreen> {
  HabitAllNoteScreenController _allNoteScreenController;

  @override
  void initState() {
    super.initState();
    _allNoteScreenController = Get.put(HabitAllNoteScreenController());

    _allNoteScreenController.updateHabitId(Get.arguments);
    // print(_allNoteScreenController.habitId.value);

    _allNoteScreenController.readDateData().then((value) {
      setState(() {});
    }).catchError((err) => debugPrint(err.toString()));

    _allNoteScreenController.readAllNoteData().then((value) {
      if (value != null && value.length != 0) {
        setState(() {});
      }
    }).catchError((err) => debugPrint(err.toString()));
  }

  @override
  void setState(fn) {
    if (this.mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitAllNoteScreenAppBar(),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            ...List.generate(
              _allNoteScreenController.dateList.length,
              (index) {
                return Container(
                  child: Column(
                    children: [
                      _allNoteScreenController.dateListWidget[index],
                      SizedBox(height: 20.0),
                      _allNoteScreenController.noteContentBoxes[index],
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// [App Bar]
  Widget _habitAllNoteScreenAppBar() {
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
        "My notes",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
