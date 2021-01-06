import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/challenges_screen.dart';
import 'package:habit_tracker/ui/habit_categories_screen.dart';
import 'package:habit_tracker/ui/all_habits_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'main_screen.dart';

class ManageScreen extends StatefulWidget {
  ManageScreen({Key key}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  var _currentIndex;
  var _screens;
  var _iconList;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    _screens = [
      MainScreen(),
      AllHabitsScreen(),
      ChallengesScreen(),
    ];

    _iconList = [
      Icons.list_alt,
      Icons.bar_chart,
      Icons.flag_rounded,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF368B8B),
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 500),
              child: HabitCategoriesScreen(),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          height: 56,
          child: Row(
            children: <Widget>[
              ...List.generate(
                3,
                (index) => _bottomBarButton(_iconList[index], index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBarButton(IconData icon, index) {
    return Container(
      padding: index == 0
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1)
          : EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
      child: IconButton(
        icon: Icon(
          icon,
          color: _currentIndex == index ? Colors.red : Colors.grey,
          size: 30.0,
        ),
        onPressed: () {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
