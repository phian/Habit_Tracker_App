import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/controller/habit_statistic_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import 'create_and_edit_habit_screen/edit_habit_screen.dart';
import 'habit_all_note_screen/habit_all_note_screen.dart';

class HabitStatisticScreen extends StatefulWidget {
  @override
  _HabitStatisticScreenState createState() => _HabitStatisticScreenState();
}

class _HabitStatisticScreenState extends State<HabitStatisticScreen> {
  AnimateIconController _controller = AnimateIconController();
  HabitStatisticController _habitStatisticController =
      Get.put(HabitStatisticController());
  CalendarController _calendarController = CalendarController();
  AllHabitController _habitController = Get.put(AllHabitController());

  @override
  void initState() {
    super.initState();
    if (Get.arguments != null) {
      _habitStatisticController.habit.value = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      appBar: _habitStatisticScreenAppBar(),
      body: _habitStatisticScreenBody(),
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
            onStartIconPress: () => _onBackButtonPress(),
            onEndIconPress: () => true,
            duration: Duration(milliseconds: 200),
            startIconColor: AppColors.cFFFF,
            endIconColor: AppColors.cFFFF,
            clockwise: true,
          ),
          onPressed: null,
        ),
      ),
      actions: [
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          offset: Offset(0.0, 58.0),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _moveToEditHabitScreen(),
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
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Obx(
                    () => InkWell(
                      onTap: () => _onPopMenuPauseItemPress(),
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
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 50.0,
                  child: InkWell(
                    onTap: () => _showDeleteDialog(),
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
                ),
              ),
            ),
            PopupMenuItem(
              child: Container(
                alignment: Alignment.center,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _moveToHabitAllNoteScreen(),
                    borderRadius: BorderRadius.circular(90.0),
                    child: Container(
                      alignment: Alignment.center,
                      width: 58.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      child: Icon(
                        Icons.event_note,
                        size: 25.0,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
      backgroundColor: AppColors.c0000,
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
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    IconData(
                      _habitStatisticController.habit.value.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    size: 50.0,
                    color: Color(
                      int.parse(
                        _habitStatisticController.habit.value.mau,
                        radix: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      _habitStatisticController.habit.value.ten,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible:
              _habitStatisticController.habit.value.soLan == 0 ? false : true,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 80.0, top: 15.0),
                child: Obx(
                  () => Row(
                    children: [
                      Text(
                        _habitStatisticController.finishedAmount.value
                            .toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFFFE,
                        ),
                      ),
                      Text(
                        "/" +
                            _habitStatisticController.habit.value.soLan
                                .toString() +
                            " ",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFF21.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        _habitStatisticController.habit.value.donVi,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFFA7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 80.0),
                child: Obx(
                  () => FAProgressBar(
                    currentValue: 0,
                    maxValue: _habitStatisticController.habit.value.soLan,
                    size: 5,
                    backgroundColor: AppColors.cFF2F,
                    progressColor: AppColors.cFFFE,
                    displayTextStyle: TextStyle(color: AppColors.c0000),
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
                        color: AppColors.cFFA7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      _habitStatisticController.habit.value.loaiLap == 0
                          ? 'Daily'
                          : 'Weekly',
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
                        color: AppColors.cFFA7,
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
            color: AppColors.cFF2F,
            borderRadius: BorderRadius.circular(30.0),
          ),
          height: Get.height * 0.55,
          child: TableCalendar(
            locale: 'vi_VN',
            calendarController: _calendarController,
            calendarStyle: CalendarStyle(selectedColor: AppColors.cFFFE),
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
            color: AppColors.cFF0A,
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
                          color: AppColors.cFFA7,
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
                            color: AppColors.cFFC7,
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
                          color: AppColors.cFFA7,
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
              _completeRateAndTotalTimesWidget(
                icon: Icons.show_chart,
                title: _habitStatisticController.completeRate,
                description: "Habit complete rate",
                iconColor: AppColors.cFFFE,
              ),
              _completeRateAndTotalTimesWidget(
                icon: Icons.check,
                title: _habitStatisticController.totalTimeComplete,
                description: "Total time completed",
                iconColor: AppColors.cFF11,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _completeRateAndTotalTimesWidget(
      {IconData icon, RxString title, String description, Color iconColor}) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: Get.width * 0.45,
        height: Get.height * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.cFF2F,
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

  bool _onBackButtonPress() {
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        Get.back();
      },
    );

    return true;
  }

  /// [Pause dialog]
  void _onPopMenuPauseItemPress() {
    if (_habitStatisticController.isResumeHabit.value) {
      _showPauseDialog();
    } else {
      _habitStatisticController.changeIsResumeHabit();
    }
  }

  void _showPauseDialog() async {
    Dialog pauseDialog = Dialog(
      backgroundColor: AppColors.cFF2F,
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
                  color: AppColors.cFFA7,
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
                onPressed: () => _onPauseItemButtonPressed(),
                child: Text(
                  'Got it',
                  style: TextStyle(color: AppColors.cFF1C, fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => pauseDialog,
    );
  }

  void _onPauseItemButtonPressed() {
    _habitStatisticController.changeIsResumeHabit();
    Get.back();
  }

  /// [Delete dialog]
  void _showDeleteDialog() async {
    Dialog deleteDialog = Dialog(
      backgroundColor: AppColors.cFF2F,
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
                onTap: () => onDeleteHabitButtonPressed(),
                leading: Icon(
                  Icons.restore_outlined,
                  size: 20.0,
                  color: AppColors.cFFFE,
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
              color: AppColors.cFF1E,
            ),
            Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                onTap: () => onDeleteHabitButtonPressed(),
                leading: Icon(
                  Icons.auto_delete,
                  size: 20.0,
                  color: AppColors.cFFF5,
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
      context: context,
      builder: (BuildContext context) => deleteDialog,
    );
  }

  void onDeleteHabitButtonPressed() {
    _habitController.deleteHabit(_habitStatisticController.habit.value);
    Get.back();
  }

  /// [Move to habit all note screen]
  void _moveToHabitAllNoteScreen() {
    Get.back();
    Get.to(
          () => HabitAllNoteScreen(),
      transition: Transition.fadeIn,
      arguments: _habitStatisticController.habit.value.ma,
    );
  }

  /// [Move to edit habit screen]
  void _moveToEditHabitScreen() {
    Get.back();
    Get.to(
          () => EditHabitScreen(),
      arguments: _habitStatisticController.habit.value,
      transition: Transition.fadeIn,
    );
  }
}
