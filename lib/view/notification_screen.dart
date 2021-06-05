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
  NotificationController _notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    _notificationController.initData();

    return Scaffold(
      appBar: _notificationScreenAppBar(),
      backgroundColor: AppColors.cFF1E,
      body: _notificationScreenBody(),
    );
  }

  /// [AppBar]
  PreferredSizeWidget _notificationScreenAppBar() {
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
              Obx(
                () => _planWithTimeNotificationWidget(
                  title: "Plan for today",
                  summaryText:
                      "Morning: x habits, Afternoon: y habit, Evening: z habits, Do anytime: n habits",
                  value: _notificationController.todayPlanSwitch.value,
                  icon: Icons.assignment,
                  pickedTime: _notificationController.todayPlanPickedTime.value,
                  iconColor: AppColors.cFF11,
                  type: PickedTimeType.todayPlan,
                ),
              ),
              SizedBox(height: 30.0),
              _planWithoutTimeNotificationWidget(
                title: "Morning plan",
                summaryText:
                    "You have x habits for this morning and 4 more you can do",
                icon: Icons.wb_sunny,
                value: _notificationController.morningPlanSwitch,
                iconColor: AppColors.cFFFA,
                type: NotificationPlanType.morning,
              ),
              SizedBox(height: 30.0),
              _planWithoutTimeNotificationWidget(
                title: "Afternoon plan",
                summaryText:
                    "You have 1 habt for this afternoon and 4 more you can do",
                icon: Icons.cloud,
                value: _notificationController.afternoonPlanSwitch,
                type: NotificationPlanType.afternoon,
                iconColor: AppColors.cFFFF,
              ),
              SizedBox(height: 30.0),
              _planWithoutTimeNotificationWidget(
                title: "Evening plan",
                summaryText:
                    "You have 1 habt for this afternoon and 4 more you can do",
                icon: Icons.nights_stay,
                value: _notificationController.eveningPlanSwitch,
                iconColor: AppColors.cFFFFD9,
                type: NotificationPlanType.evening,
              ),
              SizedBox(height: 30.0),
              Obx(
                () => _planWithTimeNotificationWidget(
                  title: "Your results for today",
                  summaryText:
                      "x habits completed, y habits skiped, z habits left",
                  value: _notificationController.todayResultSwitch.value,
                  icon: Icons.view_list,
                  pickedTime: _notificationController.resultPickedTime.value,
                  iconColor: AppColors.cFFF5,
                  type: PickedTimeType.todayResult,
                ),
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

  /// Widget have time picker
  Widget _planWithTimeNotificationWidget({
    required String title,
    required IconData icon,
    required String summaryText,
    required bool value,
    required String pickedTime,
    required Color iconColor,
    required PickedTimeType type,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10.0),
      color: AppColors.cFF2F,
      child: ListTile(
        onTap: () {
          _notificationController.onDateTimeNotificationSwitchPress(type);
        },
        contentPadding: EdgeInsets.only(
          left: 24.0,
          right: 24.0,
          top: 24.0,
          bottom: 8.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(
                              icon,
                              size: 30.0,
                              color: iconColor,
                            ),
                          ),
                        ],
                      ).marginOnly(bottom: 8.0),
                      Container(
                        width: Get.width * 0.6,
                        child: Text(
                          summaryText,
                          maxLines: 5,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ).marginOnly(
                        bottom: icon == Icons.assignment ? 16.0 : 32.0,
                      ),
                    ],
                  ),
                  Switch(
                    activeColor: AppColors.cFFFE,
                    value: value,
                    onChanged: (value) => _notificationController
                        .onDateTimeNotificationSwitchPress(type),
                  ),
                ],
              ),
              Container(
                height: 0.5,
                color: AppColors.cFFFF,
              ),
              Material(
                color: AppColors.c0000,
                borderRadius: BorderRadius.circular(5.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onTap: () => _onHabitNotificationTimeTilePress(type),
                  leading: Icon(
                    Icons.access_time,
                    size: 30.0,
                    color: AppColors.cFF1C,
                  ),
                  title: Text(
                    pickedTime,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ).marginOnly(top: 4.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget without time picker
  Widget _planWithoutTimeNotificationWidget({
    required String title,
    required String summaryText,
    required IconData icon,
    required RxBool value,
    required Color iconColor,
    required NotificationPlanType type,
  }) {
    return Material(
      color: AppColors.cFF2F,
      borderRadius: BorderRadius.circular(10.0),
      child: InkWell(
        onTap: () {
          _notificationController.onNoneDateTimeNotificationSwitchPress(type);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
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
                ).marginOnly(bottom: 5.0),
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: Get.width * 0.6,
                        child: Text(
                          summaryText,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(
              () => Switch(
                activeColor: AppColors.cFFFE,
                value: value.value,
                onChanged: (value) => _notificationController
                    .onNoneDateTimeNotificationSwitchPress(type),
              ).paddingOnly(left: 32.0),
            ),
          ],
        ).paddingSymmetric(horizontal: 16.0, vertical: 24.0),
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
                "Set notification to get information about Challenges you need to complete",
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

  void _onHabitNotificationTimeTilePress(PickedTimeType type) async {
    await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        _notificationController.changePickedTime(type, value);
      }
    }, onError: (err) {
      print(err.toString());
    }).catchError((err) {
      print(err.toString());
    });
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
                    activeColor: AppColors.cFFFE,
                    value: _notificationController
                        .challengeNotificationSwitch.value,
                    onChanged: (value) {
                      _notificationController.changeChallengeSwitchValue();
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
  Widget _challengeNotificationDisplayTimeTile({
    required String title,
    required String time,
  }) {
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
    }).catchError((err) {
      debugPrint(err.toString());
    });
  }
}

enum NotificationTimeType {
  todayPlan,
  todayResult,
}

enum NotificationPlanType {
  morning,
  afternoon,
  evening,
}

enum PickedTimeType {
  todayPlan,
  todayResult,
}
