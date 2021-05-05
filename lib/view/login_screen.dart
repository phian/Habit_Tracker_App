import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/login_screen_controller.dart';

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
                child: Image.asset(
                  "${AppConstants.imagePath}register2.png",
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
                "${AppConstants.imagePath}google.png",
                "Sign in with Google",
              ).marginOnly(top: 40.0),
              _signInBox(
                "${AppConstants.imagePath}facebook.png",
                "Sign in with Facebook",
              ).marginOnly(top: 10.0),
              _signInBox(
                "${AppConstants.imagePath}ic_apple.png",
                "Sign in with Facebook",
              ).marginOnly(top: 10.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signInBox(String imagePath, String title) {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: AppColors.cFF2F,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        onTap: () async {
          switch (title) {
            case "Sign in with Google":
              var user = await _loginScreenController.signInWithGoogle();
              if (user != null) {
                _showSignInNotificationDialog();
              }
              break;
            case "Sign in with Facebook":
              var loginState =
                  await _loginScreenController.signInWithFacebook();
              if (loginState == FacebookLoginStatus.loggedIn) {
                _showSignInNotificationDialog();
              }
              break;
          }
        },
        leading: Image.asset(
          imagePath,
          width: 35.0,
          height: 35.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showSignInNotificationDialog({
    String title,
    String text,
  }) async {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      animType: CoolAlertAnimType.slideInUp,
      title: title,
      text: text,
    );
  }
}
