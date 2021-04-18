import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/habit_all_note_screen_controller.dart';

import '../habit_note_screen.dart';

class NoteContentCard extends StatelessWidget {
  final RxString content;
  final HabitAllNoteScreenController controller;

  NoteContentCard({this.content, this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          Get.to(
            HabitNoteScreen(),
            arguments: controller.habitId.value,
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          alignment: Alignment.centerLeft,
          width: Get.width - 20.0,
          height: Get.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.cFF2F,
          ),
          child: Text(
            content.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}