import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';


class ScreenMenu extends StatelessWidget {
  final Widget child;
  final GlobalKey menuKey;

  ScreenMenu({this.child, this.menuKey});

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: AppColors.cFF2F,
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
                    backgroundColor: AppColors.cFFFF,
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
                      color: AppColors.cFFFF,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.access_time,
                    "Notification",
                    AppColors.cFF11,
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.settings,
                    "General",
                    AppColors.cFF93,
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.login,
                    "Login",
                    AppColors.cFFFA,
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
            Get.toNamed(Routes.NOTIFICATION);
          } else if (icon == Icons.settings) {
            Get.toNamed(Routes.GENERAL);
          } else {
            Get.toNamed(Routes.LOGIN);
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
            color: AppColors.cFFFF,
            fontSize: 20.0,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
