import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'package:habit_tracker/view/view_variables/create_habit_screen_variables.dart';

class CreateAndEditHabitScreenAppBar extends StatelessWidget {
  final CreateHabitScreenController controller;
  final String title;

  CreateAndEditHabitScreenAppBar({this.controller, this.title});

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
            onStartIconPress: () =>
                controller.onBackIconButtonClick(controller),
            onEndIconPress: () => true,
            duration: Duration(milliseconds: 200),
            color: Colors.white,
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
            onTap: () => controller.saveHabitData(habitScreenContext),
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
        title,
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
}
