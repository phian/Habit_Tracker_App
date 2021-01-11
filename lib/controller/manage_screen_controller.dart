import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/all_habits_screen.dart';
import 'package:habit_tracker/view/challenges_screen.dart';
import 'package:habit_tracker/view/main_screen.dart';

class ManageScreenController extends GetxController {
  var currentIndex = 0.obs;
  var screens = [
    MainScreen(),
    AllHabitsScreen(),
    ChallengesScreen(),
  ];
  var iconList = [
    Icons.list_alt,
    Icons.bar_chart,
    Icons.flag_rounded,
  ];

  void changeScreen(RxInt index) {
    currentIndex.value = index.value;
  }
}
