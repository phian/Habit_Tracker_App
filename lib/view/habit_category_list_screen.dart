import 'package:flutter/material.dart';

class HabitCategoryListScreen extends StatefulWidget {
  HabitCategoryListScreen({Key key}) : super(key: key);

  @override
  _HabitCategoryListScreenState createState() =>
      _HabitCategoryListScreenState();
}

class _HabitCategoryListScreenState extends State<HabitCategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Habit Category List Screen"),
      ),
    );
  }
}
