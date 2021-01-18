import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/view/habit_statistic_screen.dart';
import 'package:habit_tracker/view/login_screen.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'genaral_screeen.dart';
import 'notification_screen.dart';

class AllHabitsScreen extends StatelessWidget {
  AllHabitController allHabitController = Get.put(AllHabitController());
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Color(0xFF2F313E),
      key: _sideMenuKey,
      inverse: false,
      type: SideMenuType.slideNRotate,
      menu: _buildMenu(),
      child: Scaffold(
        backgroundColor: Color(0xFF1E212A),
        appBar: _allHabitScreenAppBar(),
        body: Obx(
          () => Container(
            child: allHabitController.listAllHabit.length == 0
                ? _noneHabitDisplayWidget()
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
          onPressed: () {
            final _state = _sideMenuKey.currentState;
            if (_state.isOpened)
              _state.closeSideMenu();
            else
              _state.openSideMenu();
          },
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
      itemCount: allHabitController.listAllHabit.length,
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
                    IconData(allHabitController.listAllHabit[index].icon,
                        fontFamily: 'MaterialIcons'),
                    size: 50,
                    color: Color(
                      int.parse(
                        allHabitController.listAllHabit[index].mau,
                        radix: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      allHabitController.listAllHabit[index].ten,
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
          onTap: () {
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

            Get.to(
              HabitStatisticScreen(),
              transition: Transition.fadeIn,
              arguments: allHabitController.listAllHabit[index],
            );
          },
        );
      },
    );
  }

  /// [Side menu]
  Widget _buildMenu() {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // LText(
                  //   "\l.lead{Hello},\n\l.lead.bold{User}",
                  //   baseStyle: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20.0,
                  //   ),
                  // ),
                  Text(
                    "Hello, User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.access_time,
                    "Notification",
                    Color(0xFF11C480),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.settings,
                    "General",
                    Color(0xFF933DFF),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.login,
                    "Login",
                    Color(0xFFFABB37),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Widget cho Side menu]
  Widget _menuListTile(IconData icon, String title, Color iconColor) {
    return Container(
      transform: Matrix4.translationValues(-15.0, .0, .0),
      width: 250.0,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () {
          if (icon == Icons.access_time) {
            Get.to(
              NotificationScreen(),
              transition: Transition.fadeIn,
            );
          } else if (icon == Icons.settings) {
            Get.to(
              GeneralScreen(),
              transition: Transition.fadeIn,
            );
          } else {
            Get.to(
              LoginScreen(),
              transition: Transition.fadeIn,
            );
          }
        },
        leading: Icon(
          icon,
          size: 30.0,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  /// [Widget hiển thị khi ko có habit náo trong database]
  Widget _noneHabitDisplayWidget() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/plant_pot.png",
                width: Get.width * 0.27,
                height: Get.height * 0.27,
              ),
              Text(
                "All tree grown.\nPlant new by clicking \"+\" button",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
