import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/manage_screen.dart';

void main() => runApp(GetMaterialApp(
      theme: ThemeData.dark(),
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    ));

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
        Get.offAll(ManageScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          body: Center(child: Text("Intro Screen")),
        ),
      ),
    );
  }
}
