import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file:///D:/DDisk/source/Android_DoAnFlutterJava/habit_tracker/lib/view/general_screen/genaral_screeen.dart';
import 'package:habit_tracker/view/login_screen.dart';
import 'package:habit_tracker/view/notification_screen.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ScreenMenu extends StatelessWidget {
  final Widget child;
  final GlobalKey menuKey;
  ScreenMenu({this.child, this.menuKey});

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Color(0xFF2F313E),
      key: menuKey,
      inverse: false,
      type: SideMenuType.slideNRotate,
      menu: _buildMenu(),
      child: child,
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
}