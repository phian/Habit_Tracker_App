import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/challenges_screen_controller.dart';
import 'package:habit_tracker/view/challenge_time_line_screen.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class ChallengesScreen extends StatefulWidget {
  ChallengesScreen({Key key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  ChallengesScreenController _controller = Get.put(
    ChallengesScreenController(),
  );
  final GlobalKey<SideMenuState> _challengeScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "ChallengeScreenKey",
  );

  @override
  void initState() {
    super.initState();
    _controller.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: _challengeScreenKey,
      child: Scaffold(
        backgroundColor: Color(0xFF1E212A),
        appBar: _challengesScreenAppBar(),
        body: _challengesScreenBody(),
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
          onPressed: () =>
              _controller.openOrCloseSideMenu(sideMenuKey: _challengeScreenKey),
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
      centerTitle: true,
      backgroundColor: Colors.black12,
      elevation: 0.0,
    );
  }

  Widget _challengesScreenBody() {
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
          Hero(
            tag: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                height: Get.height * 0.22,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Color(0xFF2F313E),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () => _controller.moveToChallengeScreen(
                    tag: 0,
                    title: _controller.challengeTitles[7],
                    challengeAmount: "10345",
                    imagePath: "images/morning_challenge.png",
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
                                margin: EdgeInsets.only(
                                    top: Get.height * 0.3 * 0.1),
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
                  onTap: () => _controller.moveToChallengeScreen(
                    tag: index + 1,
                    title: _controller.challengeTitles[index],
                    challengeAmount: _controller.challengeAmounts[index],
                    imagePath: _controller.imagePaths[index],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  child: Hero(
                    tag: index + 1,
                    child: _allChallengeCard(
                      _controller.challengeTitles[index],
                      _controller.challengeAmounts[index],
                      _controller.imagePaths[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(width: 20.0);
              },
              itemCount: _controller.challengeTitles.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _allChallengeCard(String title, String joinAmount, String imagePath) {
    return Material(
      color: Colors.transparent,
      elevation: 0.0,
      child: Container(
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
      ),
    );
  }
}
