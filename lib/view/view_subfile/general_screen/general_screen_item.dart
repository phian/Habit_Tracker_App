import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';

class GenralScreenItem extends StatelessWidget {
  final GeneralScreenController generalScreenController;
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool isSwitch;
  final RxBool toggle;

  GenralScreenItem({
    this.generalScreenController,
    this.icon,
    this.iconColor,
    this.isSwitch,
    this.title,
    this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: Color(0xFF2F313E),
      ),
      child: ListTile(
        onTap: () => generalScreenController.changeSwitchData(title),
        leading: Icon(
          icon,
          color: iconColor,
          size: 30.0,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 25.0),
        ),
        trailing: isSwitch == false
            ? Icon(Icons.keyboard_arrow_right_outlined)
            : Obx(
                () => Switch(
                  value: toggle.value,
                  onChanged: (value) =>
                      generalScreenController.changeSwitchData(title),
                ),
              ),
      ),
    );
  }
}
