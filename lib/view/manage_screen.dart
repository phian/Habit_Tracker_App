import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_routes.dart';
import 'package:habit_tracker/controller/manage_screen_controller.dart';



class ManageScreen extends StatelessWidget {
  final controller = Get.find<ManageScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.cFFFE,
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.SUGGEST_CATEGORY);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppColors.c1F00,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          height: 56,
          child: Row(
            children: <Widget>[
              ...List.generate(
                controller.iconList.length,
                (index) => Obx(
                  () => _bottomBarButton(
                    controller.iconList[index],
                    index,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBarButton(IconData icon, int index) {
    return Container(
      padding: index == 0
          ? EdgeInsets.only(left: Get.width * 0.05)
          : EdgeInsets.only(left: Get.width * 0.09),
      child: IconButton(
        icon: Icon(
          icon,
          color: controller.currentIndex.value == index
              ? AppColors.cFFFE
              : AppColors.cFF9E,
          size: 30.0,
        ),
        onPressed: () {
          controller.changeScreen(index);
        },
      ),
    );
  }
}
