import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';

import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/view/habit_statistic_screen.dart';
import 'package:habit_tracker/widgets/none_habit_display.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:shrink_sidemenu/src/base.dart';

class AllHabitsScreen extends StatelessWidget implements SideMenuModel {
  final mainScreenController = Get.put(MainScreenController());

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: AppConstant.allHabitScreenKey,
      child: Scaffold(
        backgroundColor: AppColors.cFF1E,
        appBar: _allHabitScreenAppBar(),
        body: Obx(
          () => Container(
            child: mainScreenController.listAllHabit.length == 0
                ? NoneHabitDisplayWidget()
                : _listAllHabit(),
          ),
        ),
      ),
    );
  }

  /// [App Bar]
  Widget _allHabitScreenAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: AppColors.cFFFF,
          ),
          onPressed: () => openOrCloseSideMenu(
            AppConstant.allHabitScreenKey,
          ),
        ),
      ),
      title: Container(
        child: Text(
          "All habit",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: AppColors.c1F00,
      elevation: 0.0,
    );
  }

  /// [Habit list]
  Widget _listAllHabit() {
    return ListView.separated(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      itemCount: mainScreenController.listAllHabit.length,
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration:
                BoxDecoration(color: AppColors.cFF2F, borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    IconData(mainScreenController.listAllHabit[index].icon,
                        fontFamily: 'MaterialIcons'),
                    size: 50,
                    color: Color(
                      int.parse(
                        mainScreenController.listAllHabit[index].mau,
                        radix: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      mainScreenController.listAllHabit[index].ten,
                      style: TextStyle(
                        fontSize: 22,
                        //fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () => _moveToHabitStatisticScreen(index),
          // print(_allHabitController.listAllHabit[index].ma);
          // print(_allHabitController.listAllHabit[index].ten);
          // print(_allHabitController.listAllHabit[index].mau);
          // print(_allHabitController.listAllHabit[index].icon);
          // print(_allHabitController.listAllHabit[index].batMucTieu);
          // print(_allHabitController.listAllHabit[index].soLan);
          // print(_allHabitController.listAllHabit[index].donVi);
          // print(_allHabitController.listAllHabit[index].loaiLap);
          // print(_allHabitController.listAllHabit[index].ngayTrongTuan);
          // print(_allHabitController.listAllHabit[index].soLanTrongTuan);
          // print(_allHabitController.listAllHabit[index].buoi);
          // print(_allHabitController.listAllHabit[index].trangThai);
        );
      },
    );
  }

  @override
  void openOrCloseSideMenu(GlobalKey<SideMenuState> key) {
    if (key.currentState.isOpened)
      key.currentState.closeSideMenu();
    else
      key.currentState.openSideMenu();
  }

  /// Navigation
  void _moveToHabitStatisticScreen(int index) {
    Get.toNamed(
      '/statistic',
      
      arguments: mainScreenController.listAllHabit[index],
    );
  }
}
