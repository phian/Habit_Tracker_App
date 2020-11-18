import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/main_screen.dart';
import 'package:habit_tracker/ui/processes_screen.dart';

class ManageScreen extends StatefulWidget {
  ManageScreen({Key key}) : super(key: key);

  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  var _currentIndex;
  var _screens;

  var _pageController;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    _pageController = PageController(initialPage: 0);

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
        body: PageView.builder(
          onPageChanged: _changePage,
          controller: _pageController,
          itemCount: _screens.length,
          itemBuilder: (BuildContext context, int index) {
            return _screens.elementAt(_currentIndex);
          },
        ),
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
                      Icons.home,
                      color: _currentIndex == 0 ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_currentIndex != 0) {
                          _currentIndex = 0;
                          _onItemTapped(_currentIndex);
                        }
                      });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: _currentIndex == 1 ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (_currentIndex != 1) {
                        _currentIndex = 1;
                        _onItemTapped(_currentIndex);
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changePage(int value) {
    setState(() {
      if (value != _currentIndex) _currentIndex = value;
    });
  }

  void _onItemTapped(int index) {
    //bottomNavigationBar and PageView association
    //bottomNavigationBar and PageView association
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
