import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/habit_statistic_controller.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:table_calendar/table_calendar.dart';

import 'edit_habit.dart';

class HabitStatisticScreen extends StatelessWidget {
  Habit _habit;

  BuildContext _context;
  AnimateIconController _controller = AnimateIconController();
  HabitStatisticController _habitStatisticController =
      HabitStatisticController();

  CalendarController _calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    _habit = Get.arguments;
    _updateHabitStatisticInfo();

    _context = context;
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitStatisticScreenAppBar(),
      body: _habitStatisticScreenBody(),
    );
  }

  void _updateHabitStatisticInfo() {
    _habitStatisticController.updateHabitStatisticInfo(
      icon: IconData(_habit.icon, fontFamily: 'MaterialIcons'),
      habitName: _habit.ten,
      goalAmount: _habit.soLan,
      goalUnitType: _habit.donVi,
      repeatType: _habit.loaiLap,
      iconColor: _habit.mau,
    );
  }

  /// [Appbar]
  Widget _habitStatisticScreenAppBar() {
    return AppBar(
      leading: Container(
        transform: Matrix4.translationValues(-3.0, -3.2, 0.0),
        child: IconButton(
          icon: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu_rounded,
            size: 30.0,
            controller: _controller,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  Get.back();
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
          onPressed: null,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(
              EditHabitScreen(),
              arguments: Get.arguments,
              transition: Transition.fadeIn,
            );
          },
          borderRadius: BorderRadius.circular(90.0),
          child: Container(
            alignment: Alignment.center,
            width: 58.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
            ),
            child: Icon(
              Icons.edit_outlined,
              size: 25.0,
            ),
          ),
        ),
        Obx(
          () => InkWell(
            onTap: () {
              if (_habitStatisticController.isResumeHabit.value) {
                _showPauseDialog();
              } else {
                _habitStatisticController.chageIsResumeHabit();
              }
            },
            borderRadius: BorderRadius.circular(90.0),
            child: Container(
              alignment: Alignment.center,
              width: 58.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90.0),
              ),
              child: Icon(
                _habitStatisticController.isResumeHabit.value == true
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 25.0,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _showDeleteDialog();
          },
          borderRadius: BorderRadius.circular(90.0),
          child: Container(
            alignment: Alignment.center,
            width: 58.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90.0),
            ),
            child: Icon(
              Icons.delete_outline,
              size: 25.0,
            ),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  /// [Body]
  Widget _habitStatisticScreenBody() {
    return ListView(
      padding: EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 20.0,
        top: 10.0,
      ),
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        Obx(
          () => Container(
            child: Row(
              children: [
                Icon(
                  _habitStatisticController.habitIcon.value,
                  size: 50.0,
                  color: Color(
                    int.parse(
                      _habitStatisticController.iconColor.value,
                      radix: 16,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Text(
                    _habitStatisticController.habitName.value,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: _habit.soLan == 0 ? false : true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 80.0, top: 15.0),
                child: Row(
                  children: [
                    Text(
                      _habitStatisticController.finishedAmount.value.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "/" +
                          _habitStatisticController.goalAmount.value
                              .toString() +
                          " ",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      _habitStatisticController.goalUnitType.value,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA7AAB1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 80.0),
                child: Obx(
                  () => FAProgressBar(
                    currentValue:
                        _habitStatisticController.finishedAmount.value,
                    maxValue: _habitStatisticController.goalAmount.value,
                    size: 5,
                    backgroundColor: Color(0xFF2F313E),
                    progressColor: Colors.blue,
                    displayTextStyle: TextStyle(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, left: 80.0),
          child: Row(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Repeat:",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFA7AAB1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _habitStatisticController.repeatType.value,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: (Get.width - 104) * 0.45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Remind:",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFFA7AAB1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _habitStatisticController.remindTime.value,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            color: Color(0xFF2F313E),
            borderRadius: BorderRadius.circular(30.0),
          ),
          height: Get.height * 0.55,
          child: TableCalendar(
            locale: 'vi_VN',
            calendarController: _calendarController,
            calendarStyle: CalendarStyle(selectedColor: Colors.blue),
            availableGestures: AvailableGestures.none,
            // headerVisible: false,
            initialSelectedDay: DateTime.now(),
            startDay: DateTime.now(),
            endDay: DateTime.now(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            color: Color(0xFF0A6AED),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.centerRight,
                transform:
                    Matrix4.translationValues(Get.width * 0.02, 0.0, 0.0),
                child: ClipRRect(
                  child: Image.asset(
                    "images/medal.png",
                    fit: BoxFit.contain,
                    height: Get.height * 0.3 * 0.9,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: Get.height * 0.3 * 0.18,
                  left: 26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _habitStatisticController.currentStreak.value + " days",
                      style: TextStyle(
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Your current streak",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA7AAB1),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "images/trophy.png",
                            width: 30.0,
                            height: 30.0,
                            color: Color(0xFFC7E436),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              _habitStatisticController.longestStreak.value +
                                  " days",
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Your longest streak",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA7AAB1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _comPleteRateAndTotalTimesWidget(
                icon: Icons.show_chart,
                title: _habitStatisticController.completeRate,
                description: "Habit complete rate",
                iconColor: Color(0xFFFE7352),
              ),
              _comPleteRateAndTotalTimesWidget(
                icon: Icons.check,
                title: _habitStatisticController.totalTimeComplete,
                description: "Total time completed",
                iconColor: Color(0xFF11C480),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _comPleteRateAndTotalTimesWidget(
      {IconData icon, RxString title, String description, Color iconColor}) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: Get.width * 0.45,
        height: Get.height * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xFF2F313E),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(
                icon,
                size: 30.0,
                color: iconColor,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              title.value + (icon == Icons.show_chart ? " %" : ""),
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Pause dialog]
  _showPauseDialog() async {
    Dialog pauseDialog = Dialog(
      backgroundColor: Color(0xFF2F313E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Paused a habit? It's still on your schedule and can be resued when you're ready",
                style: TextStyle(
                  color: Color(0xFFA7AAB1),
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () {
                  _habitStatisticController.chageIsResumeHabit();
                  Get.back();
                },
                child: Text(
                  'Got it',
                  style: TextStyle(color: Color(0xFF1C8EFE), fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
      context: _context,
      builder: (BuildContext context) => pauseDialog,
    );
  }

  /// [Delete dialog]
  _showDeleteDialog() async {
    Dialog deleteDialog = Dialog(
      backgroundColor: Color(0xFF2F313E),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)), //this right here
      child: Container(
        height: Get.height * 0.2,
        width: Get.width * 0.7,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.2 * 0.1),
              child: Text(
                "Delete habit?",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: ListTile(
                onTap: () {
                  Get.back();
                },
                leading: Icon(
                  Icons.restore_outlined,
                  size: 20.0,
                  color: Color(0xFFFE7352),
                ),
                title: Text(
                  "Clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 1.0,
              color: Color(0xFF1E212A),
            ),
            Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                onTap: () {
                  Get.back();
                },
                leading: Icon(
                  Icons.auto_delete,
                  size: 20.0,
                  color: Color(0xFFF53566),
                ),
                title: Text(
                  "Delete habit and clear history",
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: _context,
      builder: (BuildContext context) => deleteDialog,
    );
  }
}
