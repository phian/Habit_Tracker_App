import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  PageController _pageController;
  var _selectedIndex;

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

    _pageController = PageController();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    initWeekDates();

    return Scaffold(
      backgroundColor: Color(0xFF50B47B),
      body: SafeArea(
        child: Stack(
          children: [
            Stack(
              children: [
                _cloudIcon(
                  10.0,
                  MediaQuery.of(context).size.width * 0.3,
                  50.0,
                ),
                _cloudIcon(
                  MediaQuery.of(context).size.height * 0.18,
                  MediaQuery.of(context).size.width * 0.8,
                  80.0,
                ),
                _cloudIcon(
                  30.0,
                  0,
                  40.0,
                  MediaQuery.of(context).size.width * 0.3,
                ),
                _treeIcon(
                  "images/tree1.png",
                  MediaQuery.of(context).size.height * 0.3,
                  30.0,
                  70.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.35,
                  80.0,
                  40.0,
                ),
                _treeIcon(
                  "images/tree1.png",
                  MediaQuery.of(context).size.height * 0.4,
                  MediaQuery.of(context).size.width * 0.8,
                  70.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.45,
                  MediaQuery.of(context).size.width * 0.9,
                  40.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.45,
                  MediaQuery.of(context).size.width * 0.75,
                  40.0,
                ),
                _treeIcon(
                  "images/tree1.png",
                  MediaQuery.of(context).size.height * 0.7,
                  MediaQuery.of(context).size.width * 0.1,
                  70.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.75,
                  MediaQuery.of(context).size.width * 0.15,
                  40.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.74,
                  MediaQuery.of(context).size.width * 0.24,
                  40.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.73,
                  MediaQuery.of(context).size.width * 0.05,
                  40.0,
                ),
                _treeIcon(
                  "images/tree1.png",
                  MediaQuery.of(context).size.height * 0.75,
                  MediaQuery.of(context).size.width * 0.8,
                  70.0,
                ),
                _treeIcon(
                  "images/grass.png",
                  MediaQuery.of(context).size.height * 0.8,
                  MediaQuery.of(context).size.width * 0.75,
                  40.0,
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          size: 35.0,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
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

  Widget _cloudIcon(double marginTop, double marginLeft, double iconSize,
      [double marginRight]) {
    return Container(
      alignment: Alignment.topCenter,
      margin: marginRight == null
          ? EdgeInsets.only(top: marginTop, left: marginLeft)
          : EdgeInsets.only(
              top: marginTop,
              right: marginRight,
            ),
      child: Icon(
        Icons.cloud,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }

  Widget _treeIcon(
      String imagePath, double marginTop, double marginLeft, double imageSize,
      [double marginRight]) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight != null ? marginRight : 0.0,
      ),
      child: Image.asset(
        imagePath,
        width: imageSize,
        height: imageSize,
      ),
    );
  }
}
