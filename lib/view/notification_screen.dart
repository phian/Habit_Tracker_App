import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/notification_screen_controller.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _notificationScreenAppBar(),
      backgroundColor: AppColors.cFF1E,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _changeNotificationScreenButton("Habits", 1),
              Container(width: 1.0, color: AppColors.cFF00, height: 40.0),
              _changeNotificationScreenButton("Challenges", 2),
            ],
          ).paddingSymmetric(horizontal: 24.0),
        ),
      ),
      title: Text(
        "Notifications",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.cFF2F,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Change notification type button]
  Widget _changeNotificationScreenButton(String title, int index) {
    return Expanded(
      child: Obx(
        () => InkWell(
          onTap: () => _notificationController.changeIsHabitsOrChallenge(
            index,
          ),
          borderRadius: index == 1
              ? BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
          child: Container(
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _notificationController.isHabitsOrChallenge.value == index
                  ? AppColors.cFF1C
                  : AppColors.c3DFF,
              borderRadius: index == 1
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }

  /// Body
  Widget _notificationScreenBody() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        padding: EdgeInsets.only(bottom: 20.0),
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          _habitNotificationListColumn(),
          _challengeNotificationBox(),
        ],
      ),
    );
  }

  /// [Habit notification list column]
  Widget _habitNotificationListColumn() {
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
                  color: AppColors.cFFA7,
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
                iconColor: AppColors.cFF11,
                type: NotificationTimeType.todayPlan,
              ),
              SizedBox(height: 30.0),
              _dateTimeNotiWidget(
                title: "Morning plan",
                summaryText:
                    "You have x habits for this morning and 4 more you can do",
                icon: Icons.wb_sunny,
                value: _notificationController.isOnOrOffMorningPlan,
                iconColor: AppColors.cFFFA,
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
                iconColor: AppColors.cFFFFD9,
              ),
              SizedBox(height: 30.0),
              _todayPlanAndResultWidget(
                title: "Your results for today",
                summaryText:
                    "x habits completed, y habits skiped, z habits left",
                value: _notificationController.isOnOrOffTodayResult,
                icon: Icons.view_list,
                pickedTime: _notificationController.resultNotiPickedTime,
                iconColor: AppColors.cFFF5,
                type: NotificationTimeType.todayResult,
              ),
              SizedBox(height: 30.0),
              Text(
                "You can also set reminder for each habit in the settings",
                style: TextStyle(
                  fontSize: 20.0,
                  color: AppColors.cFFA7,
                ),
              ),
              SizedBox(height: 30.0),
              Material(
                color: AppColors.cFF2F,
                borderRadius: BorderRadius.circular(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onTap: () {},
                  leading: Icon(
                    Icons.settings_outlined,
                    color: AppColors.cFF1C,
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
    NotificationTimeType type,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.cFF2F,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    () => Switch(
                      activeColor: AppColors.cFF1C,
                      value: value.value,
                      onChanged: (value) => _notificationController
                          .onDateTimeNotificationSwitchPress(icon),
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
              color: AppColors.cFFFF,
            ),
            Container(
              child: Material(
                color: AppColors.c0000,
                borderRadius: BorderRadius.circular(5.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onTap: () => _onHabitNotificationTilePress(icon, type),
                  leading: Icon(
                    Icons.access_time,
                    size: 30.0,
                    color: AppColors.cFF1C,
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
      padding: EdgeInsets.symmetric(horizontal: 23.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.cFF2F,
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
                          activeColor: AppColors.cFFFE,
                          value: value.value,
                          onChanged: (value) => _notificationController
                              .onNoneDateTimeNotificationSwitchPress(icon),
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
                  color: AppColors.cFFA7,
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
        color: AppColors.cFF2F,
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
            color: AppColors.c1FFF,
          ),
          SizedBox(height: 10.0),
          Obx(
            () => _challengeNotificationDisplayTimeTile(
              title: "Plan for today",
              time: _notificationController.challengeTodayPlanTime.value,
            ),
          ),
          SizedBox(height: 10.0),
          Obx(
            () => _challengeNotificationDisplayTimeTile(
              title: "Progress check up",
              time: _notificationController.challengeProgressCheckUpTime.value,
            ),
          ),
        ],
      ),
    );
  }

  /// [Challenge display time tile]
  Widget _challengeNotificationDisplayTimeTile({String title, String time}) {
    return Material(
      color: AppColors.c0000,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onTap: () => _onChallengeNotificationTilePress(title),
        leading: Icon(
          Icons.access_time,
          color: AppColors.cFF1C,
          size: 30.0,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.0,
            color: AppColors.cFFA7,
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

  void _onChallengeNotificationTilePress(String title) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        if (title.toLowerCase() == "plan for today") {
          _notificationController.changeChallengeTodayPlanTime(value);
        } else {
          _notificationController.changeProgressCheckUpTime(value);
        }
      }
    }).catchError((err) => debugPrint(err.toString()));
  }

  void _onHabitNotificationTilePress(
      IconData icon, NotificationTimeType type) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        switch (type) {
          case NotificationTimeType.todayPlan:
            _notificationController.changePickedTime(0, value);
            break;
          case NotificationTimeType.todayResult:
            _notificationController.changePickedTime(1, value);
            break;
        }
      }
    }).catchError((err) => print(err.toString()));
  }
}

enum NotificationTimeType {
  todayPlan,
  todayResult,
}
