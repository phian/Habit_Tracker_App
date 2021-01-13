import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/challenge_time_line_screen.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'notification_screen.dart';

class ChallengesScreen extends StatefulWidget {
  ChallengesScreen({Key key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  List<String> _challengeTitles, _chalengeAmounts, _imagePaths;

  @override
  void initState() {
    super.initState();

    _challengeTitles = [
      "Social Media Detox Challenge",
      "Bedtime Routine Challenge",
      "Sugar Free Challenge",
      "Intermittent Fasting Challenge",
      "No Alcohol Challenge",
      "Mindfullness Challenge",
      "Relationship Challenge",
      "Happy Morning Chalenge",
    ];
    _chalengeAmounts = [
      "776",
      "443",
      "313",
      "201",
      "215",
      "412",
      "228",
      "10355",
    ];
    _imagePaths = [
      "images/social_media_challenge.png",
      "images/bedtime_routine_challenge.png",
      "images/sugar_free_challenge.png",
      "images/intermittent_fasting_challenge.png",
      "images/no_alcohol_challenge.png",
      "images/mindfulness_chllenge.png",
      "images/relationship_challenge.png",
      "images/morning_challenge.png",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SideMenu(
      background: Color(0xFF2F313E),
      key: _sideMenuKey,
      inverse: false,
      type: SideMenuType.slideNRotate,
      menu: _buildMenu(),
      child: Scaffold(
        backgroundColor: Color(0xFF1E212A),
        appBar: _challengesScreenAppBar(),
        body: __challengesScreenBody(),
      ),
    );
  }

  Widget _challengesScreenAppBar() {
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: Colors.white,
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
      title: Container(
        child: Text(
          "Challenges",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  Widget __challengesScreenBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          Text(
            "JOIN A CHALLENGE",
            style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFFA7AAB1),
            ),
          ),
          InkWell(
            onTap: () {
              _moveToChallengeTimelineScreen(
                0,
                _challengeTitles[7],
                "10345",
                "images/morning_challenge.png",
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Hero(
              tag: 0,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: Get.height * 0.22,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFF2F313E),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        "images/morning_challenge.png",
                        fit: BoxFit.contain,
                        width: Get.width * 0.45,
                        height: Get.height * 0.22,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15.0),
                          Container(
                            width: Get.width * 0.5,
                            child: Text(
                              "Happy morning challenge",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "7 days",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFFA7AAB1),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(30.0),
                            child: Container(
                              width: 120.0,
                              height: 30.0,
                              margin:
                                  EdgeInsets.only(top: Get.height * 0.3 * 0.1),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Text(
                                "10345 joined",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFFE2C372),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Text(
            "ALL CHALLENGES",
            style: TextStyle(
              fontSize: 15.0,
              color: Color(0xFFA7AAB1),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            height: Get.height * 0.27,
            width: Get.width,
            child: ListView.separated(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _moveToChallengeTimelineScreen(
                      index + 1,
                      _challengeTitles[index],
                      _chalengeAmounts[index],
                      _imagePaths[index],
                    );
                  },
                  borderRadius: BorderRadius.circular(20.0),
                  child: Hero(
                    tag: index + 1,
                    child: _allChalengeCard(
                      _challengeTitles[index],
                      _chalengeAmounts[index],
                      _imagePaths[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 20.0);
              },
              itemCount: _challengeTitles.length,
            ),
          ),
        ],
      ),
    );
  }

  void _moveToChallengeTimelineScreen(
    int tag,
    String title,
    String challengeAmount,
    String imagePath,
  ) {
    Get.to(
      ChallengeTimeLineScreen(
        tag: tag,
        title: title,
        challengeAmount: challengeAmount,
        imagePath: imagePath,
      ),
    );
  }

  Widget _allChalengeCard(String title, String joinAmount, String imagePath) {
    return Container(
      width: Get.width * 0.75,
      decoration: BoxDecoration(
        color: Color(0xFF2F313E),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5.0),
            padding: EdgeInsets.only(top: Get.height * 0.27 * 0.18),
            alignment: Alignment.centerRight,
            child: Image.asset(
              imagePath,
              height: Get.height * 0.27 * 0.65,
              width: Get.width * 0.75 * 0.5,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "7 days",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFFA7AAB1),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    width: 120.0,
                    height: 30.0,
                    margin: EdgeInsets.only(top: Get.height * 0.3 * 0.2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      "$joinAmount joined",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFE2C372),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return Container(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35.0,
                    child: Icon(
                      Icons.account_circle,
                      size: 60.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // LText(
                  //   "\l.lead{Hello},\n\l.lead.bold{User}",
                  //   baseStyle: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20.0,
                  //   ),
                  // ),
                  Text(
                    "Hello, User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.access_time,
                    "Notification",
                    Color(0xFF11C480),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.settings,
                    "General",
                    Color(0xFF933DFF),
                  ),
                  SizedBox(height: 20.0),
                  _menuListTile(
                    Icons.login,
                    "Login",
                    Color(0xFFFABB37),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuListTile(IconData icon, String title, Color iconColor) {
    return Container(
      transform: Matrix4.translationValues(-15.0, .0, .0),
      width: 250.0,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () {
          if (icon == Icons.access_time) {
            Get.to(
              NotificationScreen(),
              transition: Transition.fadeIn,
            );
          }
        },
        leading: Icon(
          icon,
          size: 30.0,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
        trailing: Icon(Icons.keyboard_arrow_right),
      ),
    );
  }
}
