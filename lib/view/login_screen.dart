import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/constants/app_images.dart';
import 'package:habit_tracker/controller/login_screen_controller.dart';
import 'package:habit_tracker/widgets/alert_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenController _loginScreenController = LoginScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.cFF1E,
      appBar: _loginScreenAppBar(),
      body: _loginScreenBody(),
    );
  }

  /// [App Bar]
  Widget _loginScreenAppBar() {
    return AppBar(
      backgroundColor: AppColors.cFF1E,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Body]
  Widget _loginScreenBody() {
    return _signInForm();
  }

  /// [Sign up form]
  Widget _signInForm() {
    return Container(
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: Get.height * 0.15,
            ),
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppImages.imgRegister2,
                  fit: BoxFit.contain,
                  width: Get.width * 0.71,
                  height: Get.height * 0.32,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                alignment: Alignment.center,
                child: Text(
                  "Let's join us",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _signInBox(
                LoginType.google,
              ).marginOnly(top: 40.0),
              _signInBox(
                LoginType.facebook,
              ).marginOnly(top: 10.0),
              _signInBox(
                LoginType.apple,
              ).marginOnly(top: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signInBox(LoginType type) {
    return Material(
      color: AppColors.cFF2F,
      borderRadius: BorderRadius.circular(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onTap: () async {
          switch (type) {
            case LoginType.google:
              var user = await _loginScreenController.signInWithGoogle();
              if (user != null) {
                Get.back(result: "Success");
                showAlert(
                  text: "Sign in success",
                  title: "Alert!",
                  type: CoolAlertType.success,
                  context: context,
                );
              }
              break;
            case LoginType.facebook:
              var loginState =
              await _loginScreenController.signInWithFacebook();
              if (loginState == FacebookLoginStatus.success) {
                Get.back(result: "Success");
                showAlert(
                  text: "Sign in success",
                  title: "Alert!",
                  type: CoolAlertType.success,
                  context: context,
                );
              }
              break;
            case LoginType.apple:
              break;
          }
        },
        leading: SvgPicture.asset(
          type.loginTypeIcon,
          width: 35.0,
          height: 35.0,
          color: type == LoginType.apple ? AppColors.cFFFF : null,
        ),
        title: Text(
          type.loginTypeText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
