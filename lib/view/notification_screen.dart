import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/notification_screen_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationController _notificationController = NotificationController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: _notificationScreenAppBar(),
      backgroundColor: Color(0xFF1E212A),
      body: _notificationScreenBody(),
    );
  }

  /// [AppBar]
  Widget _notificationScreenAppBar() {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size(Get.width, Get.height * 0.1),
        child: Container(
          height: 60.0,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: Get.width * 0.45 * 0.9,
                  bottom: 10.0,
                ),
                alignment: Alignment.center,
                child: _changeNotiScreenButton("Challenges", 2),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: Get.width * 0.08,
                  bottom: 10.0,
                ),
                alignment: Alignment.centerLeft,
                child: _changeNotiScreenButton("Habits", 1),
              ),
            ],
          ),
        ),
      ),
      title: Text(
        "Notifications",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xFF2F313E),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Change notification type button]
  Widget _changeNotiScreenButton(String title, int index) {
    return Obx(
      () => InkWell(
        onTap: () {
          _notificationController.changeIsHabitsOrChallenge(RxInt(index));
        },
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: Get.width * 0.45,
          height: 40.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _notificationController.isHabitsOrChallenge.value == index
                ? Color(0xFF1C8EFE)
                : Colors.white24,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  /// [Body]
  Widget _notificationScreenBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20.0),
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          _habitNoticationListColumn(),
          _challengeNotificationBox(),
        ],
      ),
    );
  }

  /// [Habit notification list column]
  Widget _habitNoticationListColumn() {
    return Obx(
      () => Visibility(
        visible: _notificationController.isHabitsOrChallenge.value == 1
            ? true
            : false,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text(
                "Set notifications to get information about the habits you need to complete",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFA7AAB1),
                ),
              ),
              SizedBox(height: 30.0),
              _todayPlanAndResultWidget(
                title: "Plan for today",
                summaryText:
                    "Morning: x habits, Afternoon: y habit, Evening: z habits, Do anytime: n habits",
                value: _notificationController.isOnOrOffTodayPlanNoti,
                icon: Icons.assignment,
                pickedTime: _notificationController.todayPlanPickedTime,
                iconColor: Color(0xFF11C480),
              ),
              SizedBox(height: 30.0),
              _dateTimeNotiWidget(
                title: "Morning plan",
                summaryText:
                    "You have x habits for this morning and 4 more you can do",
                icon: Icons.wb_sunny,
                value: _notificationController.isOnOrOffMorningPlan,
                iconColor: Color(0xFFFABB37),
              ),
              SizedBox(height: 30.0),
              _dateTimeNotiWidget(
                title: "Afternoon plan",
                summaryText:
                    "You have 1 habt for this afternoon and 4 more you can do",
                icon: Icons.cloud,
                value: _notificationController.isOnOrOffAternoonPlan,
              ),
              SizedBox(height: 30.0),
              _dateTimeNotiWidget(
                title: "Evening plan",
                summaryText:
                    "You have 1 habt for this afternoon and 4 more you can do",
                icon: Icons.nights_stay,
                value: _notificationController.isOnOrOffEveningPlan,
                iconColor: Color(0xFFFFD93B),
              ),
              SizedBox(height: 30.0),
              _todayPlanAndResultWidget(
                title: "Plan for today",
                summaryText:
                    "x habits completed, y habit skiped, z habits left",
                value: _notificationController.isOnOrOffTodayResult,
                icon: Icons.flag,
                pickedTime: _notificationController.resultNotiPickedTime,
                iconColor: Color(0xFFF53566),
              ),
              SizedBox(height: 30.0),
              Text(
                "You can also set reminder for each habit in the settings",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFA7AAB1),
                ),
              ),
              SizedBox(height: 30.0),
              Material(
                color: Color(0xFF2F313E),
                borderRadius: BorderRadius.circular(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onTap: () {},
                  leading: Icon(
                    Icons.settings_outlined,
                    color: Color(0xFF1C8EFE),
                  ),
                  title: Text(
                    "Change notifications settings",
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [Widget have time picker]
  Widget _todayPlanAndResultWidget({
    String title,
    IconData icon,
    String summaryText,
    RxBool value,
    RxString pickedTime,
    Color iconColor,
  }) {
    return Container(
      height: Get.height * 0.26,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF2F313E),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.25 * 0.08),
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      icon,
                      size: 30.0,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.63,
                    child: Text(
                      summaryText,
                      maxLines: 5,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Obx(
                    () => Switch(
                      activeColor: Color(0xFF1C8EFE),
                      value: value.value,
                      onChanged: (value) {
                        if (icon == Icons.assignment)
                          _notificationController
                              .changeIsOnOrOffTodayPlanOrResultNoti(0);
                        else
                          _notificationController
                              .changeIsOnOrOffTodayPlanOrResultNoti(1);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height:
                    icon == Icons.assignment ? 15.0 : Get.height * 0.26 * 0.17),
            Divider(
              thickness: 0.5,
              color: Colors.white,
            ),
            Container(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onTap: () {
                    showTimePicker(
                      context: _context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      if (icon == Icons.assignment)
                        _notificationController.changePickedtime(0, value);
                      else
                        _notificationController.changePickedtime(1, value);
                    });
                  },
                  leading: Icon(
                    Icons.access_time,
                    size: 30.0,
                    color: Color(0xFF1C8EFE),
                  ),
                  title: Obx(
                    () => Text(
                      pickedTime.value,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Widget without time picker]
  Widget _dateTimeNotiWidget({
    String title,
    String summaryText,
    IconData icon,
    RxBool value,
    Color iconColor,
  }) {
    return Container(
      height: Get.height * 0.17,
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFF2F313E),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.17 * 0.13),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(
                        icon,
                        size: 30.0,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: Get.width * 0.6,
                      child: Text(
                        summaryText,
                        maxLines: 5,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Obx(
                      () => Container(
                        padding: EdgeInsets.only(left: Get.width * 0.03),
                        child: Switch(
                          activeColor: Colors.blue,
                          value: value.value,
                          onChanged: (value) {
                            if (icon == Icons.wb_sunny) {
                              _notificationController
                                  .changeIsOnOrOffDAteTimePlanNoti(0);
                            } else if (Icons.cloud == icon) {
                              _notificationController
                                  .changeIsOnOrOffDAteTimePlanNoti(1);
                            } else {
                              _notificationController
                                  .changeIsOnOrOffDAteTimePlanNoti(2);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [Challenge notification box]
  Widget _challengeNotificationBox() {
    return Obx(
      () => Visibility(
        visible: _notificationController.isHabitsOrChallenge.value == 2
            ? true
            : false,
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text(
                "Set notification to get infromation about Challenges you need to complete",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFA7AAB1),
                ),
              ),
              _challengeNotificationCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// [Challenge notification card]
  Widget _challengeNotificationCard() {
    return Container(
      height: Get.height * 0.3,
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Color(0xFF2F313E),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (Get.width - 40) * 0.5,
                  margin: EdgeInsets.only(top: Get.height * 0.3 * 0.1),
                  child: Text(
                    "Fresh Morning Challenge",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Obx(
                  () => Switch(
                    value: _notificationController.isOnChallengeNoti.value,
                    onChanged: (value) {
                      _notificationController.changeIsOnChallengeNoti();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            height: 1,
            color: Colors.white12,
          ),
          SizedBox(height: 10.0),
          Obx(
            () => _challengeNotiDisplayTimeTile(
              title: "Plan for today",
              time: _notificationController.challengeTodayPlanTime.value,
            ),
          ),
          SizedBox(height: 10.0),
          Obx(
            () => _challengeNotiDisplayTimeTile(
              title: "Progress check up",
              time: _notificationController.challengeProgressCheckUpTime.value,
            ),
          ),
        ],
      ),
    );
  }

  /// [Challenge display time tile]
  Widget _challengeNotiDisplayTimeTile({String title, String time}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () {
          showTimePicker(
            context: _context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              if (title.toLowerCase() == "plan for today") {
                _notificationController.changeChallengeTodayPlanTime(value);
              } else {
                _notificationController.changeProgressCheckUpTime(value);
              }
            }
          });
        },
        leading: Icon(
          Icons.access_time,
          color: Color(0xFF1C8EFE),
          size: 30.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFFA7AAB1),
          ),
        ),
        trailing: Container(
          width: (Get.width - 40) * 0.18,
          transform: Matrix4.translationValues(
            (Get.width - 40) * 0.03,
            0.0,
            0.0,
          ),
          child: Row(
            children: [
              Text(
                time,
                style: TextStyle(fontSize: 18.0),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
