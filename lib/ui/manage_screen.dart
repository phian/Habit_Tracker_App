import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/processes_screen.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'main_screen.dart';

class ManageScreen extends StatefulWidget {
  ManageScreen({Key key}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  var _currentIndex;
  var _screens;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;

    _screens = [
      MainScreen(),
      ProcessesScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green,
        body: _screens[_currentIndex],
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.list_alt,
                      color: _currentIndex == 0 ? Colors.red : Colors.grey,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.bar_chart,
                      color: _currentIndex == 1 ? Colors.red : Colors.grey,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
