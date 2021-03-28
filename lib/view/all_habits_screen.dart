import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/view/habit_statistic_screen.dart';
import 'package:habit_tracker/widgets/none_habit_display.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class AllHabitsScreen extends StatelessWidget {
  final AllHabitController _allHabitController = Get.put(AllHabitController());
  final GlobalKey<SideMenuState> _allHabitScreenKey =
      GlobalKey<SideMenuState>(debugLabel: "AllHabitScreenKey");

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: _allHabitScreenKey,
      child: Scaffold(
        backgroundColor: Color(0xFF1E212A),
        appBar: _allHabitScreenAppBar(),
        body: Obx(
          () => Container(
            child: _allHabitController.listAllHabit.length == 0
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
            color: Colors.white,
          ),
          onPressed: () => _allHabitController.openOrCloseSideMenu(
            sideMenuKey: _allHabitScreenKey,
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
      backgroundColor: Colors.black12,
      elevation: 0.0,
    );
  }

  /// [Habit list]
  Widget _listAllHabit() {
    return ListView.separated(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      itemCount: _allHabitController.listAllHabit.length,
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xFF2F313E),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Icon(
                    IconData(_allHabitController.listAllHabit[index].icon,
                        fontFamily: 'MaterialIcons'),
                    size: 50,
                    color: Color(
                      int.parse(
                        _allHabitController.listAllHabit[index].mau,
                        radix: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      _allHabitController.listAllHabit[index].ten,
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
          onTap: () => _allHabitController.moveToHabitStatisticScreen(index),
          // print(allHabitController.listAllHabit[index].ma);
          // print(allHabitController.listAllHabit[index].ten);
          // print(allHabitController.listAllHabit[index].mau);
          // print(allHabitController.listAllHabit[index].icon);
          // print(allHabitController.listAllHabit[index].batMucTieu);
          // print(allHabitController.listAllHabit[index].soLan);
          // print(allHabitController.listAllHabit[index].donVi);
          // print(allHabitController.listAllHabit[index].loaiLap);
          // print(allHabitController.listAllHabit[index].ngayTrongTuan);
          // print(allHabitController.listAllHabit[index].soLanTrongTuan);
          // print(allHabitController.listAllHabit[index].buoi);
          // print(allHabitController.listAllHabit[index].trangThai);
        );
      },
    );
  }
}
