import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'package:get/get.dart';

TextEditingController habitNameController = new TextEditingController();
ScrollController screenScrollController = new ScrollController();
AnimateIconController aniController = new AnimateIconController();
CreateHabitScreenController createHabitScreenController =
    Get.put(CreateHabitScreenController());

List<Color> choiceColors = [
  Color(0xFFF53566),
  Color(0xFF11C480),
  Color(0xFF1C8EFE),
  Color(0xFFFABB37),
  Color(0xFFFE7352),
  Color(0xFF933DFF),
];
List<String> weekDayChoices = [
  "M",
  "T",
  "W",
  "T",
  "F",
  "S",
  "S",
];
final List<Map<String, dynamic>> unitTypes = [
  {
    'value': 'of times',
    'icon': Container(
      padding: EdgeInsets.only(right: Get.width * 0.05),
      child: Icon(Icons.calculate_outlined),
    ),
    'textStyle': TextStyle(fontSize: 20.0),
  },
  {
    'value': 'glass',
    'icon': Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Icon(Icons.local_drink),
    ),
    'textStyle': TextStyle(fontSize: 20.0),
  },
  {
    'value': 'km',
    'icon': Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Icon(Icons.directions_walk),
    ),
    'textStyle': TextStyle(fontSize: 20.0),
  },
  {
    'value': 'pages',
    'icon': Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Icon(CupertinoIcons.book),
    ),
    'textStyle': TextStyle(fontSize: 20.0),
  },
  {
    'value': 'time',
    'icon': Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Icon(Icons.timer),
    ),
    'textStyle': TextStyle(fontSize: 20.0),
  },
];

BuildContext createHabitScreenContext;
