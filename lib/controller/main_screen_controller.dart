import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {
  var selectedDay = DateTime.now().obs;

  changeSelectedDay(DateTime date) {
    if (selectedDay.value != date) {
      selectedDay.value = date;
    }
  }
}
