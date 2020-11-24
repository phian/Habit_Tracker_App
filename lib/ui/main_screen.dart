import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/ui_subfile/main_screen_trees.dart';
import 'package:intl/intl.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var dateNames;
  var dates;
  var calendarCards;
  var dateColors;
  var selectedIndex;

  var habitDataList;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    super.initState();

    dateNames = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];
    dates = [];
    calendarCards = [];
    dateColors = [
      Colors.black,
      Color(0xFF50B47B),
    ];

    selectedIndex = 0;

    habitDataList = [];

    initWeekDates();
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: _sideMenuKey,
      inverse: true,
      type: SideMenuType.slideNRotate,
      menu: buildMenu(),
      child: Scaffold(
        backgroundColor: Color(0xFF50B47B),
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 62.0),
          child: AppBar(
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20.0),
                alignment: Alignment.center,
                child: IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    size: 35.0,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    final _state = _sideMenuKey.currentState;
                    if (_state.isOpened)
                      _state.closeSideMenu();
                    else
                      _state.openSideMenu();
                  },
                ),
              ),
            ],
            title: Text(
              "Today",
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              MainScreenTreesAndCloud(),
              Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: calendarCards[0],
                          onTap: () {
                            print("0 tapped");
                            changeCalendarBorderColor(0);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[1],
                          onTap: () {
                            print("1 tapped");
                            changeCalendarBorderColor(1);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[2],
                          onTap: () {
                            print("2 tapped");
                            changeCalendarBorderColor(2);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[3],
                          onTap: () {
                            print("3 tapped");
                            changeCalendarBorderColor(3);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[4],
                          onTap: () {
                            print("4 tapped");
                            changeCalendarBorderColor(4);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[5],
                          onTap: () {
                            print("5 tapped");
                            changeCalendarBorderColor(5);
                          },
                        ),
                        GestureDetector(
                          child: calendarCards[6],
                          onTap: () {
                            print("6 tapped");
                            changeCalendarBorderColor(6);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      "Tracking habits",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    child: Divider(),
                    margin: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: habitDataList.length > 0
                        ? ListView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(""),
                              )
                            ],
                          )
                        : Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/gardener.png',
                                  fit: BoxFit.cover,
                                  height: 120.0,
                                  width: 120.0,
                                  alignment: Alignment.center,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30.0,
                                    vertical: 15.0,
                                  ),
                                  child: Text(
                                    "All tree are grown up. Let's plan another tree",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget calendarCard(
      String dateName, String date, Color textColor, bool isVisible) {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      height: 80.0,
      width: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          30.0,
        ),
        color: isVisible ? Colors.white : Colors.transparent,
      ),
      child: Column(
        children: [
          Text(
            dateName,
            style: TextStyle(fontSize: 20.0, color: textColor),
          ),
          Text(
            date,
            style: TextStyle(
              fontSize: 25.0,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  void initWeekDates() {
    for (int i = 0; i < 7; i++) {
      dates.add(
        DateTime.now().add(
          Duration(days: i),
        ),
      );
    }

    initCalenderCards();
  }

  void initCalenderCards() {
    for (int i = 0; i < 7; i++) {
      calendarCards.add(
        calendarCard(
          dateNames[i],
          DateFormat('dd').format(
            dates[i],
          ),
          DateFormat('dd MM yyyy').format(
                    dates[i],
                  ) ==
                  DateFormat('dd MM yyyy').format(
                    DateTime.now(),
                  )
              ? dateColors[1]
              : dateColors[0],
          DateFormat('dd MM yyyy').format(
                    dates[i],
                  ) ==
                  DateFormat('dd MM yyyy').format(
                    DateTime.now(),
                  )
              ? true
              : false,
        ),
      );
    }
  }

  // Hàm dùng khi ng dùng ấn vào 1 ô ngày nào đó
  void changeCalendarBorderColor(int index) {
    if (selectedIndex != index) {
      setState(() {
        calendarCards[index] = calendarCard(
            dateNames[index],
            DateFormat('dd').format(
              dates[index],
            ),
            DateFormat('dd MM yyyy').format(
                      dates[index],
                    ) ==
                    DateFormat('dd MM yyyy').format(
                      DateTime.now(),
                    )
                ? dateColors[1]
                : dateColors[0],
            true);

        calendarCards[selectedIndex] = calendarCard(
            dateNames[selectedIndex],
            DateFormat('dd').format(
              dates[selectedIndex],
            ),
            DateFormat('dd MM yyyy').format(
                      dates[selectedIndex],
                    ) ==
                    DateFormat('dd MM yyyy').format(
                      DateTime.now(),
                    )
                ? dateColors[1]
                : dateColors[0],
            false);

        selectedIndex = index;
      });
    }
  }

  Widget buildMenu() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35.0,
                ),
                SizedBox(height: 16.0),
                LText(
                  "\l.lead{Hello},\n\l.lead.bold{Johnie}",
                  baseStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
