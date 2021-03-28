import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';
import 'package:habit_tracker/model/app_pallete_color.dart';
import 'package:habit_tracker/view/view_subfile/general_screen/general_screen_item.dart';

class GeneralScreenVariables {
  List<Widget> generalScreenItems;
  List<IconData> icons;
  List<String> titles;
  List<bool> isSwitches;
  List<RxBool> toggles;
  final GeneralScreenController controller;

  GeneralScreenVariables({this.toggles, this.controller}) {
    generalScreenItems = [];
    icons = [];
    titles = [];
    isSwitches = [];
  }

  void initData() {
    icons = [
      Icons.brightness_7,
      Icons.calendar_today,
      Icons.badge,
      Icons.phone_android,
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
      'Minimalist Interface',
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
      true,
      false,
      true,
      false,
      true,
      false,
      false,
    ];

    for (int i = 0; i < 11; i++) {
      generalScreenItems.add(
        GenralScreenItem(
          generalScreenController: controller,
          title: titles[i],
          icon: icons[i],
          iconColor: AppPalleteColor.appPalleteColor[i],
          isSwitch: isSwitches[i],
          toggle: toggles[i],
        ),
      );
    }
  }
}
