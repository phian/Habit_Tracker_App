import 'package:animate_icons/animate_icons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'file:///D:/DDisk/source/Android_DoAnFlutterJava/habit_tracker/lib/view/create_and_edit_habit_screen/create_habit_screen_variables.dart';

class CreateAndEditHabitScreenAppBar extends StatefulWidget {
  final CreateHabitScreenController controller;
  final String title;
  final TextEditingController goalAmountController, habitNameController;

  CreateAndEditHabitScreenAppBar({
    this.controller,
    this.title,
    this.goalAmountController,
    this.habitNameController,
  });

  @override
  _CreateAndEditHabitScreenAppBarState createState() =>
      _CreateAndEditHabitScreenAppBarState();
}

class _CreateAndEditHabitScreenAppBarState
    extends State<CreateAndEditHabitScreenAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Get.size.height * 0.25,
      collapsedHeight: Get.size.height * 0.075,
      backgroundColor: Color(0xFF2F313E),
      pinned: true,
      flexibleSpace: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Image.asset(
              "images/forest.png",
              fit: BoxFit.cover,
              width: Get.size.width,
              height: Get.size.height * 0.3,
            ),
          ),
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.close,
            endIcon: Icons.arrow_back,
            size: 25.0,
            controller: aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () => _onBackIconButtonClick(),
            onEndIconPress: () => true,
            duration: Duration(milliseconds: 200),
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            clockwise: true,
          ),
        ),
        onTap: () {},
      ),
      actions: [
        Container(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            onTap: () => _saveHabitData(),
            child: Container(
              alignment: Alignment.center,
              width: 70.0,
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  /// [Hàm để lưu data vào databaee]
  void _saveHabitData() async {
    if ((widget.goalAmountController.text == '' ||
            int.parse(widget.goalAmountController.text) == 0) &&
        widget.controller.selectedIndex.value == 0) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        animType: CoolAlertAnimType.slideInUp,
        title: "Forgot to set a goal?",
        text: "Check your goal for this habit",
      );
    } else if (widget.habitNameController.text == '' ||
        widget.habitNameController.text.isEmpty) {
      print(widget.habitNameController.text);
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        animType: CoolAlertAnimType.slideInUp,
        title: "Forgot to set a name?",
        text: "Check the name you want for this habit",
      );
    } else {
      widget.controller.addHabit(
        widget.habitNameController.text,
        widget.goalAmountController.text,
      );
      Get.back();
      Get.back();
      //Get.offAll(ManageScreen());
      widget.habitNameController.clear();
      widget.controller.onClose();
    }
  }

  bool _onBackIconButtonClick() {
    Future.delayed(Duration(milliseconds: 200), () {
      Get.back();
      widget.controller.onClose();
      widget.habitNameController.clear();
      widget.goalAmountController.clear();
    });

    return true;
  }
}