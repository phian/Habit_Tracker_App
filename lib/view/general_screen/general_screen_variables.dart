import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';
import 'package:habit_tracker/view/general_screen/general_screen_item.dart';

class GeneralScreenVariables {
  late List<Widget> generalScreenItems;
  late List<IconData> icons;
  late List<String> titles;
  late List<bool> isSwitches;
  final GeneralScreenController controller;
  late List<String> startWeekChoices;
  late List<String> unitOfMeasureChoices;
  late List<String> notificationToneChoices;

  GeneralScreenVariables({required this.controller}) {
    generalScreenItems = [];
    icons = [];
    titles = [];
    isSwitches = [];
    initChoiceData();
  }

  void initData() {
    icons = [
      Icons.brightness_7,
      Icons.calendar_today,
      Icons.badge,
      Icons.beach_access,
      Icons.straighten,
      Icons.volume_down,
      Icons.music_note,
      Icons.lock_rounded,
      Icons.delete_forever,
      Icons.build,
    ];

    titles = [
      'Time of day',
      'Start week on',
      'Icon badge',
      'Vacation mode',
      'Units of Measure',
      'Sounds',
      'Notification tone',
      'Passcode lock',
      'Clean Slate Protocol',
      'Export Data',
    ];

    isSwitches = [
      false,
      false,
      true,
      true,
      false,
      true,
      false,
      true,
      false,
      false,
    ];

    for (int i = 0; i < 10; i++) {
      generalScreenItems.add(
        GeneralScreenItem(
          generalScreenController: controller,
          title: titles[i],
          icon: icons[i],
          iconColor: AppColors.appColors[i],
          isSwitch: isSwitches[i],
          type: GeneralItemType.values[i],
        ),
      );
    }
  }

  void initChoiceData() {
    startWeekChoices = [
      "Auto",
      "Sunday",
      "Monday",
      "Saturday",
    ];
    unitOfMeasureChoices = [
      "Imperial",
      "Metric",
    ];
    notificationToneChoices = [
      "Ascending",
      "Electric Piano",
      "Echo",
      "Radar",
      "Since Wave",
    ];
  }
}
