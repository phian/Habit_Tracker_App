import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/widgets/side_menu/side_menu_controller.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ScreenMenu extends StatefulWidget {
  final Widget child;
  final GlobalKey menuKey;

  ScreenMenu({this.child, this.menuKey});

  @override
  _ScreenMenuState createState() => _ScreenMenuState();
}

class _ScreenMenuState extends State<ScreenMenu> {
  final SideMenuController _menuController = Get.put(SideMenuController());

  @override
  void initState() {
    super.initState();
    _menuController.initUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: AppColors.cFF2F,
      key: widget.menuKey,
      inverse: false,
      type: SideMenuType.slideNRotate,
      menu: _buildMenu(),
      child: widget.child,
    );
  }

  /// [Side menu]
  Widget _buildMenu() {
    _menuController.initUserInfo();

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
                  Container(
                    width: 70.0,
                    child: ClipOval(
                      child: Obx(
                        () => _menuController.imagePath.value.isEmpty
                            ? Icon(
                                Icons.account_circle,
                                size: 60.0,
                              )
                            : Image.network(
                                _menuController.imagePath.value,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Obx(
                    () => Text(
                      "Hello, ${_menuController.userName.value}",
                      style: TextStyle(
                        color: AppColors.cFFFF,
                        fontSize: 20.0,
                      ),
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
        onTap: () async {
          if (icon == Icons.access_time) {
            Get.toNamed(Routes.NOTIFICATION);
          } else if (icon == Icons.settings) {
            Get.toNamed(Routes.GENERAL);
          } else {
            var result = await Get.toNamed(Routes.LOGIN);
            if (result != null) {
              _menuController.initUserInfo();
            }
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
