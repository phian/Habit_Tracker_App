import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/habit_all_note_screen_controller.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/view/habit_all_note_screen/date_divider.dart';

import 'package:habit_tracker/view/habit_all_note_screen/no_note_data_display_widget.dart';
import 'package:habit_tracker/view/habit_all_note_screen/note_content_card.dart';

class HabitAllNoteScreen extends StatefulWidget {
  HabitAllNoteScreen({Key key}) : super(key: key);

  @override
  _HabitAllNoteScreenState createState() => _HabitAllNoteScreenState();
}

class _HabitAllNoteScreenState extends State<HabitAllNoteScreen> {
  HabitAllNoteScreenController _allNoteScreenController;
  int habitId;
  @override
  void initState() {
    super.initState();
    habitId = Get.arguments;
    _allNoteScreenController = Get.put(HabitAllNoteScreenController());

    _allNoteScreenController.getAllNote(habitId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      appBar: _habitAllNoteScreenAppBar(),
      body: Obx(
        () => _allNoteScreenController.loadingState.value == AllNoteLoadingState.isLoaded &&
                _allNoteScreenController.listNote.length != 0
            ? ListView.builder(
                itemCount: _allNoteScreenController.listNote.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: [
                        DateDivider(
                          date: _allNoteScreenController.listNote[index].date,
                        ),
                        SizedBox(height: 20.0),
                        GestureDetector(
                          child: NoteContentCard(
                            content: _allNoteScreenController.listNote[index].content,
                          ),
                          onTap: () => Get.toNamed(
                            Routes.NOTE,
                            arguments: [
                              habitId,
                              DateTime.parse(_allNoteScreenController.listNote[index].date),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            : _allNoteScreenController.loadingState.value == AllNoteLoadingState.isLoading
                ? SpinKitFadingCube(color: AppColors.cFFFF)
                : NoNoteDataDisplayWidget(),
      ),
    );
  }

  /// [App Bar]
  Widget _habitAllNoteScreenAppBar() {
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
        "My notes",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
