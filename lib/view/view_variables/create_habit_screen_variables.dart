import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'package:get/get.dart';

ScrollController screenScrollController = new ScrollController();
AnimateIconController aniController = new AnimateIconController();

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
    'value': 'glasses',
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
    'value': 'hours',
    'icon': Container(
      padding: EdgeInsets.only(right: 25.0),
      child: Icon(Icons.access_time),
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

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '0');

    if (newValue.text.length > 3)
      return TextEditingValue().copyWith(
        text: newValue.text.substring(0, 3),
      );
    else
      return newValue;
  }
}
