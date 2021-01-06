import 'dart:ffi';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/ui/habit_categories_screen.dart';
import 'package:page_transition/page_transition.dart';

class CreateHabitScreen extends StatefulWidget {
  final String title;
  CreateHabitScreen({Key key, this.title}) : super(key: key);

  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  TextEditingController _habitNameController,
      _endGoalController,
      _habitGoalController;

  ScrollController _screenScrollController;
  // double _scrollDistance;

  AnimateIconController _aniController;

  bool _goalForHabitCheck,
      _dayRepeatCheck,
      _dailyRepeatCheck,
      _endGoalCheck,
      _isReminderOn,
      _isOfTimesGoal;

  List<String> _goalTitles, _dailyRepeatTitles;
  String _repeatType;
  Color _endGoalIconColor, _habitGoalColor;

  @override
  void initState() {
    super.initState();

    _habitNameController = new TextEditingController();
    _endGoalController = new TextEditingController();
    _habitGoalController = new TextEditingController();
    _aniController = new AnimateIconController();

    // _scrollDistance = 0.0;
    _screenScrollController = new ScrollController();
    // ..addListener(() {
    //   // makes sure we don't call setState too much, but only when it is needed
    //   if (_screenScrollController.position.userScrollDirection ==
    //       ScrollDirection.forward)
    //     setState(() {
    //       _scrollDistance++;
    //     });
    //   else
    //     setState(() {
    //       _scrollDistance--;
    //     });
    // });

    _goalForHabitCheck = false;
    _dayRepeatCheck = false;
    _dailyRepeatCheck = false;
    _endGoalCheck = false;
    _isReminderOn = true;
    _isOfTimesGoal = true;

    _endGoalIconColor = new Color(0xFFF63566);
    _habitGoalColor = new Color(0xFFF63566);

    _goalTitles = [
      "Daily",
      "Weekly",
      "Monthly",
    ];

    _dailyRepeatTitles = [
      "Morning",
      "Afternoon",
      "Evening",
    ];

    _repeatType = "day";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF368B8B),
      // resizeToAvoidBottomInset: false,
      body: _createHabitScreenBody(),
    );
  }

  // Widget chứa body của màn hình
  Widget _createHabitScreenBody() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _screenScrollController,
      slivers: [
        _habitScreenAppBar(),
        _habitScreenBody(),
      ],
    );
  }

  // AppBar
  Widget _habitScreenAppBar() {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.25,
      collapsedHeight: MediaQuery.of(context).size.height * 0.075,
      backgroundColor: Color(0xDD226D6D),
      pinned: true,
      flexibleSpace: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Image.asset(
              "images/forest.png",
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.close,
            endIcon: Icons.arrow_back,
            size: 25.0,
            controller: _aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500),
                      child: HabitCategoriesScreen(),
                    ),
                  );
                },
              );

              return true;
            },
            onEndIconPress: () {
              return true;
            },
            duration: Duration(milliseconds: 200),
            color: Colors.white,
            clockwise: true,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 500),
              child: HabitCategoriesScreen(),
            ),
          );
        },
      ),
      actions: [
        Container(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 70.0,
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "robotoslab",
                ),
              ),
            ),
          ),
        )
      ],
      title: Text(
        widget.title,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontFamily: "robotoslab",
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  //====================================================//

  // Body

  Widget _habitScreenBody() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 30.0,
          horizontal: 15.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: _habitNameController,
              decoration: InputDecoration(
                hintText: "Name your habit",
                hintStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                fillColor: Colors.white24,
                filled: true,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20.0,
                right: MediaQuery.of(context).size.width * 0.15,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(90.0),
                    child: Container(
                      width: 55.0,
                      height: 55.0,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(
                          90.0,
                        ),
                      ),
                      child: Icon(
                        Icons.circle,
                        size: 35.0,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      "Color",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  setState(() {
                    _goalForHabitCheck = !_goalForHabitCheck;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Goal for Habit",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.grey[350], // Your color
                      ),
                      child: Checkbox(
                        value: _goalForHabitCheck,
                        checkColor: Colors.black,
                        onChanged: (isChanged) {
                          setState(() {
                            _goalForHabitCheck = !_goalForHabitCheck;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isOfTimesGoal = !_isOfTimesGoal;
                      });
                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.43,
                      height: 40.0,
                      child: Text(
                        "# of times",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "robotoslab",
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white24,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isOfTimesGoal = !_isOfTimesGoal;
                      });
                    },
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: 40.0,
                      child: Text(
                        "Time",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "robotoslab",
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _habitGoalController,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "robotoslab",
              ),
              keyboardType: TextInputType.number,
              maxLength: 3,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty)
                    _habitGoalColor = Color(0xFFF63566);
                  else
                    _habitGoalColor = Colors.transparent;

                  if (text.length > 3) {
                    text = text.substring(0, 2);
                    _habitGoalController.text = text;
                  }
                });
              },
              decoration: InputDecoration(
                fillColor: Colors.white24,
                filled: true,
                counterText: '',
                hintText: _isOfTimesGoal ? "times" : "minutes",
                suffixIcon: Icon(
                  Icons.error,
                  color: _habitGoalColor,
                ),
                errorText: "Please enter your goal",
                errorStyle: TextStyle(
                  fontFamily: "robotoslab",
                  fontSize: 15.0,
                  color: _habitGoalColor,
                ),
                hintStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "robotoslab",
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            SizedBox(height: 20.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(_goalTitles.length, (index) {
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 120.0,
                        height: 45.0,
                        alignment: Alignment.center,
                        child: Text(
                          _goalTitles[index],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "robotoslab",
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white24,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: InkWell(
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {
                  setState(() {
                    _dayRepeatCheck = !_dayRepeatCheck;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repeat every " + _repeatType,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.grey[350], // Your color
                      ),
                      child: Checkbox(
                        value: _dayRepeatCheck,
                        checkColor: Colors.black,
                        onChanged: (isChanged) {
                          setState(() {
                            _dayRepeatCheck = !_dayRepeatCheck;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(7, (index) {
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        width: 53.0,
                        height: 53.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.0),
                          color: Colors.white24,
                        ),
                        child: Text(
                          index != 6 ? "T" : "C",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "robotoslab",
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            SizedBox(height: 40.0),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _dailyRepeatCheck = !_dailyRepeatCheck;
                  });
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Repeat daily in the:",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.grey[350], // Your color
                      ),
                      child: Checkbox(
                        value: _dailyRepeatCheck,
                        checkColor: Colors.black,
                        onChanged: (isChanged) {
                          setState(() {
                            _dailyRepeatCheck = !_dailyRepeatCheck;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    _dailyRepeatTitles.length,
                    (index) => InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        width: 130.0,
                        height: 40.0,
                        alignment: Alignment.center,
                        child: Text(
                          _dailyRepeatTitles[index],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "robotoslab",
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            SizedBox(height: 20.0),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _endGoalCheck = !_endGoalCheck;
                  });
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Set end date or goal amount",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.grey[350], // Your color
                      ),
                      child: Checkbox(
                        value: _endGoalCheck,
                        checkColor: Colors.black,
                        onChanged: (isChanged) {
                          setState(() {
                            _endGoalCheck = !_endGoalCheck;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    2,
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(20.0),
                      onTap: () {},
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 40.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white24,
                        ),
                        child: Text(
                          index == 0 ? "Date" : "Amount",
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "robotoslab",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _endGoalController,
              maxLength: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(3),
              ],
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                fontFamily: "robotoslab",
              ),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty)
                    _endGoalIconColor = Color(0xFFF63566);
                  else
                    _endGoalIconColor = Colors.transparent;

                  if (text.length > 3) {
                    text = text.substring(0, 2);
                    _endGoalController.text = text;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: "times",
                hintStyle: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "robotoslab",
                ),
                counterText: '',
                fillColor: Colors.white24,
                filled: true,
                suffixIcon: Icon(
                  Icons.error,
                  color: _endGoalIconColor,
                ),
                errorText: "Please enter your goal",
                errorStyle: TextStyle(
                  fontFamily: "robotoslab",
                  fontSize: 15.0,
                  color: _endGoalIconColor,
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blue,
                    width: 3.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            SizedBox(height: 10.0),
            Container(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isReminderOn = !_isReminderOn;
                  });
                },
                borderRadius: BorderRadius.circular(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Get reminders",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "robotoslab",
                      ),
                    ),
                    Switch(
                      value: _isReminderOn,
                      onChanged: (isChanged) {
                        setState(() {
                          _isReminderOn = isChanged;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                10.0,
              )),
              onTap: () {},
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.0),
                  color: Colors.blue.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              ),
              title: Text(
                "Add reminder time",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "robotoslab",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //====================================================//
}
