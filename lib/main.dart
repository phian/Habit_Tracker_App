import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/view/manage_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  // Biến để khởi tạo database
  DatabaseHelper _habitTrackerDatabaseHelper;

  @override
  void initState() {
    super.initState();

    _habitTrackerDatabaseHelper = DatabaseHelper.instance;
    _habitTrackerDatabaseHelper.database;

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
