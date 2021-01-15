import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/habit.dart';

class MainScreenController extends GetxController {
  var selectedDay = DateTime.now().obs;

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;
    }
  }
}
