import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_routes.dart';
import 'package:habit_tracker/controller/binding/controller_binding.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'constants/app_constant.dart';
import 'controller/binding/controller_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting()
      .then(
    (_) => runApp(
      GetMaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        initialBinding: ControllerBinding(),
        initialRoute: Routes.SPLASH_SCREEN,
        defaultTransition: Transition.cupertino,
        getPages: Pages.pages,
      ),
    ),
  )
      .catchError((err) {
    print(err.toString());
  },);
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        Get.offAllNamed(Routes.MANAGE_SCRREN);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            "${AppConstant.imagePath}habit_tracker.png",
            width: 100.0,
            height: 100.0,
          ),
        ),
      ),
    );
  }
}
