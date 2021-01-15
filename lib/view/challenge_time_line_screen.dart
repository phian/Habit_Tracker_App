import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/view/manage_screen.dart';
import 'package:habit_tracker/view/view_variables/challenge_time_line_screen_variables.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ChallengeTimeLineScreen extends StatefulWidget {
  final int tag;
  final String title, challengeAmount, imagePath;
  ChallengeTimeLineScreen({
    Key key,
    this.tag,
    this.title,
    this.challengeAmount,
    this.imagePath,
  }) : super(key: key);

  @override
  _ChallengeTimeLineScreenState createState() =>
      _ChallengeTimeLineScreenState();
}

class _ChallengeTimeLineScreenState extends State<ChallengeTimeLineScreen> {
  List<ChallengeInfo> _challengeList;
  List<String> _dateNamesList;

  @override
  void initState() {
    super.initState();

    _challengeList = [];
    _initChallengeData();

    _dateNamesList = [];
    _initDateName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      body: Hero(
        tag: widget.tag,
        child: _challengeTimelineScreenBody(),
      ),
    );
  }

  // Get data theo challenge
  void _initChallengeData() {
    switch (widget.tag) {
      case 0:
      case 8:
        _challengeList = happyMorningChallengeInfos;
        break;
      case 1:
        _challengeList = socialMediaChallengeInfos;
        break;
      case 2:
        _challengeList = bedRoutineChallengeInfos;
        break;
      case 3:
        _challengeList = sugarFreeChallengeInfos;
        break;
      case 4:
        _challengeList = intermittentFastingChallengeInfos;
        break;
      case 5:
        _challengeList = noAlcoholChallengeInfos;
        break;
      case 6:
        _challengeList = mindfulnessChallengeInfos;
        break;
      case 7:
        _challengeList = relationShipChallengeInfos;
        break;
    }
  }

  // Khởi tạo data từ ngày hiện tại
  void _initDateName() {
    for (int i = 0; i <= _challengeList.length; i++) {
      var date = DateTime.now().add(Duration(days: i));

      switch (date.weekday) {
        case 1:
          _dateNamesList.add("Mon");
          break;
        case 2:
          _dateNamesList.add("Tue");
          break;
        case 3:
          _dateNamesList.add("Wed");
          break;
        case 4:
          _dateNamesList.add("Thu");
          break;
        case 5:
          _dateNamesList.add("Fri");
          break;
        case 6:
          _dateNamesList.add("Sat");
          break;
        case 7:
          _dateNamesList.add("Sun");
          break;
      }
    }
  }

  // Widget chứa body của màn hình
  Widget _challengeTimelineScreenBody() {
    return Material(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: challengeTimelineController,
        slivers: [
          _challengeTimelineScreenAppBar(),
          _challengeTimelineScreennBody(),
        ],
      ),
    );
  }

  // AppBar
  Widget _challengeTimelineScreenAppBar() {
    return SliverAppBar(
      expandedHeight: Get.height * 0.3,
      collapsedHeight: Get.height * 0.075,
      backgroundColor: Color(0xFF2F313E),
      pinned: true,
      bottom: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.3 * 0.75),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Text(""),
        ),
      ),
      flexibleSpace: Stack(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              width: Get.width * 0.45,
              height: Get.height * 0.25,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.size.height * 0.3 * 0.35),
                Container(
                  alignment: Alignment.centerLeft,
                  width: Get.width * 0.7,
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "7 days",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFFA7AAB1),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          width: 120.0,
                          height: 30.0,
                          margin: EdgeInsets.only(top: Get.height * 0.3 * 0.07),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            widget.challengeAmount + " joined",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFFE2C372),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(
                            top: Get.height * 0.3 * 0.07,
                            left: 5.0,
                          ),
                          alignment: Alignment.center,
                          width: 70.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFF9BD33),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            "WHY",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF2F313E),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu,
            size: 30.0,
            controller: aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  Future.delayed(Duration(milliseconds: 200), () {
                    Get.back();
                  });
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
          Future.delayed(Duration(milliseconds: 200), () {
            Get.to(
              ManageScreen(),
              duration: Duration(milliseconds: 500),
              transition: Transition.fadeIn,
            );
          });
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  // Body
  Widget _challengeTimelineScreennBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            height: Get.height * 0.58,
            padding: EdgeInsets.only(bottom: 20.0, top: 15.0),
            child: Timeline(
              position: TimelinePosition.Left,
              lineColor: Colors.white12,
              lineWidth: 0.7,
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              children: [
                ...List.generate(
                  _challengeList.length,
                  (index) => TimelineModel(
                    Container(
                      margin: EdgeInsets.only(bottom: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _dateNamesList[index],
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFFA7AAB1),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: Get.height * 0.14,
                            decoration: BoxDecoration(
                              color: Color(0xFF2F313E),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListTile(
                              leading: Icon(
                                _challengeList[index].icon,
                                color: _challengeList[index].iconColor,
                                size: 40.0,
                              ),
                              title: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _challengeList[index].title,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      _challengeList[index].description,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA7AAB1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    position: TimelineItemPosition.random,
                  ),
                ),
                TimelineModel(
                  Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _dateNamesList[_dateNamesList.length - 1],
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Color(0xFFA7AAB1),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            color: Color(0xFF2F313E),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            leading: Container(
                              margin: EdgeInsets.only(
                                top: Get.height * 0.1 * 0.28,
                              ),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.white12,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  position: TimelineItemPosition.random,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: Get.width * 0.08,
              right: Get.width * 0.08,
              top: 3.0,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () {},
              child: Container(
                alignment: Alignment.center,
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF9BD33),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  "START CHALLENGE",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFF2F313E),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
