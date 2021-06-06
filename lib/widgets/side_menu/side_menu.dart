import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/login_screen_controller.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/widgets/custom_confirm_dialog.dart';
import 'package:habit_tracker/widgets/init_rate_my_app_widget.dart';
import 'package:habit_tracker/widgets/side_menu/side_menu_controller.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ScreenMenu extends StatefulWidget {
  final Widget child;
  final ZoomDrawerController menuController;

  ScreenMenu({
    required this.child,
    required this.menuController,
  });

  @override
  _ScreenMenuState createState() => _ScreenMenuState();
}

class _ScreenMenuState extends State<ScreenMenu> {
  final SideMenuController _menuController = Get.put(SideMenuController());

  @override
  void initState() {
    super.initState();
    _menuController.initUserInfo();
    Get.lazyPut(() => LoginScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return InitRateMyAppWidget(
      builder: (rateMyApp) {
        return Scaffold(
          backgroundColor: AppColors.cFF2F,
          body: ZoomDrawer(
            style: DrawerStyle.Style1,
            controller: widget.menuController,
            menuScreen: _buildMenu(rateMyApp),
            mainScreen: widget.child,
            borderRadius: 24.0,
            showShadow: true,
            angle: 0.0,
            slideWidth: Get.width / 1.5,
            duration: Duration(milliseconds: 200),
            backgroundColor: AppColors.c3DFF,
          ),
        );
      },
    );
  }

  /// [Side menu]
  Widget _buildMenu(RateMyApp rateMyApp) {
    _menuController.initUserInfo();

    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(vertical: 64.0),
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
                    type: MenuItemsType.notification,
                    icon: Icons.access_time,
                    title: "Notification",
                    iconColor: AppColors.cFF11,
                  ).marginOnly(bottom: 20.0),
                  _menuListTile(
                    type: MenuItemsType.general,
                    icon: Icons.settings,
                    title: "General",
                    iconColor: AppColors.cFF93,
                  ).marginOnly(bottom: 20.0),
                  Obx(
                    () => _menuListTile(
                      type: _menuController.imagePath.value.isEmpty
                          ? MenuItemsType.login
                          : MenuItemsType.logout,
                      icon: _menuController.imagePath.value.isEmpty
                          ? Icons.login
                          : Icons.logout,
                      title: _menuController.imagePath.value.isEmpty
                          ? "Login"
                          : "Logout",
                      iconColor: AppColors.cFFFA,
                    ),
                  ).marginOnly(bottom: 20.0),
                  _menuListTile(
                    type: MenuItemsType.help,
                    icon: Icons.help_outline,
                    title: "Help",
                    iconColor: AppColors.cFF11,
                  ).marginOnly(bottom: 20.0),
                  _menuListTile(
                    type: MenuItemsType.sendFeedback,
                    icon: Icons.feedback_outlined,
                    title: "Send feedback",
                    iconColor: AppColors.cFF1C,
                  ).marginOnly(bottom: 20.0),
                  _menuListTile(
                    type: MenuItemsType.share,
                    icon: Icons.ios_share,
                    title: "Share",
                    iconColor: AppColors.cFFF5,
                  ).marginOnly(bottom: 20.0),
                  _menuListTile(
                    type: MenuItemsType.rateApp,
                    icon: Icons.star_rate,
                    title: "Rate our app",
                    iconColor: AppColors.cFFFA,
                    rateMyApp: rateMyApp,
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
  Widget _menuListTile({
    required MenuItemsType type,
    required IconData icon,
    required String title,
    required Color iconColor,
    RateMyApp? rateMyApp,
  }) {
    return Container(
      transform: Matrix4.translationValues(-15.0, .0, .0),
      width: 250.0,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () {
          _handleOnListTileTap(type, rateMyApp);
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

  void _showSignInNotificationDialog({
    required String title,
    required String text,
  }) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      animType: CoolAlertAnimType.slideInUp,
      title: title,
      text: text,
    );
  }

  void _handleOnListTileTap(MenuItemsType type, RateMyApp? rateMyApp) async {
    switch (type) {
      case MenuItemsType.notification:
        Get.toNamed(Routes.NOTIFICATION);
        break;
      case MenuItemsType.general:
        Get.toNamed(Routes.GENERAL);
        break;
      case MenuItemsType.login:
        var result = await Get.toNamed(Routes.LOGIN);
        if (result != null) {
          _menuController.initUserInfo();
        }
        break;
      case MenuItemsType.logout:
        await _menuController.signOutUserAccount().whenComplete(() {
          _showSignInNotificationDialog(
            text: "Sign out success",
            title: "Alert!",
          );
        });
        break;
      case MenuItemsType.help:
        Get.toNamed(Routes.HELP);
        break;
      case MenuItemsType.sendFeedback:
        _showFeedbackDialog();
        break;
      case MenuItemsType.share:
        break;
      case MenuItemsType.rateApp:
        rateMyApp?.showStarRateDialog(
          context,
          title: 'Rate Our App',
          message: 'Please rate us if you like our app!',
          dialogStyle: DialogStyle(
              dialogShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0))),
          starRatingOptions: StarRatingOptions(initialRating: 4),
          actionsBuilder: (context, stars) {
            return actionsBuilder(context, stars, rateMyApp);
          },
        );
        break;
    }
  }

  void _showFeedbackDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return CustomConfirmDialog(
          title: "Feedback",
          content: "Please email us at: phiannguyen1806@gmail.com",
          onNegativeButtonTap: () {
            Navigator.pop(context);
          },
          negativeButtonText: 'Got it',
        );
      },
    );
  }

  List<Widget> actionsBuilder(
          BuildContext context, double? stars, RateMyApp? rateMyApp) =>
      stars == null
          ? [_buildCancelButton(rateMyApp!)]
          : [_buildOkButton(stars, rateMyApp!), _buildCancelButton(rateMyApp)];

  Widget _buildOkButton(double stars, RateMyApp rateMyApp) => TextButton(
        child: Text('OK'),
        onPressed: () async {
          Fluttertoast.showToast(
              msg: "Thank you for rating our app!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.cFF9E,
              textColor: AppColors.cFFFF,
              fontSize: 16.0);

          final launchAppStore = stars >= 4;

          final event = RateMyAppEventType.rateButtonPressed;

          await rateMyApp.callEvent(event);

          if (launchAppStore) {
            rateMyApp.launchStore();
          }

          Navigator.of(context).pop();
        },
      );

  Widget _buildCancelButton(RateMyApp rateMyApp) => RateMyAppNoButton(
        rateMyApp,
        text: 'CANCEL',
      );
}

enum MenuItemsType {
  notification,
  general,
  login,
  logout,
  help,
  sendFeedback,
  share,
  rateApp,
}
