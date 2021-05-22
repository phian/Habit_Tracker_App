import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/all_habits_screen.dart';
import 'package:habit_tracker/view/challenges_screen.dart';
import 'package:habit_tracker/view/main_screen/main_screen.dart';
import 'package:habit_tracker/view/step_tracking_screen/step_tracking_screen.dart';

class ManageScreenController extends GetxController {
  var currentIndex = 0.obs;
  var screens = [
    MainScreen(),
    AllHabitsScreen(),
    ChallengesScreen(),
    StepTackingScreen(),
  ];
  var iconList = [
    Icons.list_alt,
    Icons.bar_chart,
    Icons.flag_rounded,
    Icons.directions_run,
  ];

  void changeScreen(int index) {
    currentIndex.value = index;
  }
}
