import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/widgets/none_habit_display.dart';
import 'package:habit_tracker/widgets/side_menu/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../model/habit.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> implements SideMenuModel {
  final mainScreenController = Get.find<MainScreenController>();

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: AppConstants.mainScreenKey,
      child: Scaffold(
        backgroundColor: AppColors.cFF1E,
        appBar: _mainScreenAppBar(),
        body: _mainScreenBody(),
      ),
    );
  }

  /// [Appbar]
  Widget _mainScreenAppBar() {
    return AppBar(
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: AppColors.cFFFF,
          ),
          onPressed: () => openOrCloseSideMenu(
            AppConstants.mainScreenKey,
          ),
        ),
      ),
      title: Container(
        child: Obx(
          () => Text(
            mainScreenController.appBarTitle.value,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.c1C1C,
      elevation: 0.0,
    );
  }

  Widget _mainScreenBody() {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          // calendar
          Container(
            color: AppColors.c1F00,
            padding: const EdgeInsets.only(top: 11, bottom: 11),
            child: FlutterDatePickerTimeline(
              startDate: DateTime.now().subtract(Duration(days: 14)),
              endDate: DateTime.now().add(Duration(days: 14)),
              initialFocusedDate: mainScreenController.selectedDay.value,
              // initialSelectedDate: mainScreenController.selectedDay.value,
              onSelectedDateChange: (dateTime) {
                mainScreenController.updateFlagValue(true);
                mainScreenController.changeSelectedDay(dateTime);
                mainScreenController.getHabitByWeekDate(dateTime.weekday);
                mainScreenController.updateFlagValue(false);
              },
              selectedItemBackgroundColor: AppColors.c3DFF,
              selectedItemTextStyle: TextStyle(
                color: AppColors.cFFFF,
                fontSize: 18.0,
              ),
              unselectedItemBackgroundColor: AppColors.c0000,
              unselectedItemTextStyle: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    color: AppColors.c1F00,
                    child: TabBar(
                      isScrollable: true,
                      labelColor: AppColors.cFFFF,
                      unselectedLabelColor: AppColors.c3DFF,
                      indicatorColor: AppColors.c0000,
                      physics: AlwaysScrollableScrollPhysics(),
                      tabs: [
                        _mainScreenDateTimeTab('All day'),
                        _mainScreenDateTimeTab('Morning'),
                        _mainScreenDateTimeTab('Afternoon'),
                        _mainScreenDateTimeTab('Evening'),
                      ],
                    ),
                  ),
                  Obx(
                    () => Expanded(
                      child: Container(
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            mainScreenController.isLoading.value == false
                                ? _listHabit(mainScreenController.listAnytimeHabit)
                                : NoneHabitDisplayWidget(),
                            mainScreenController.isLoading.value == false
                                ? _listHabit(mainScreenController.listMorningHabit)
                                : NoneHabitDisplayWidget(),
                            mainScreenController.isLoading.value == false
                                ? _listHabit(mainScreenController.listAfternoonHabit)
                                : NoneHabitDisplayWidget(),
                            mainScreenController.isLoading.value == false
                                ? _listHabit(mainScreenController.listEveningHabit)
                                : NoneHabitDisplayWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Habit list]
  Widget _listHabit(List<Habit> _habitDataList) {
    return _habitDataList.length > 0
        ? mainScreenController.listHabitProcess.length > 0
            ? Obx(
                () => ListView.separated(
                  key: UniqueKey(),
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  itemCount: _habitDataList.length,
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    int i = mainScreenController.listHabitProcess
                        .indexWhere((e) => e.habitId == _habitDataList[index].habitId);

                    if (mainScreenController.listHabitProcess[i].result == -1 ||
                        mainScreenController.listHabitProcess[i].result ==
                                _habitDataList[index].amount &&
                            _habitDataList[index].isSetGoal == true ||
                        mainScreenController.listHabitProcess[i].isSkip == true) {
                      return swipeRightHabit(
                          _habitDataList[index], mainScreenController.listHabitProcess[i]);
                    } else {
                      return swipeHabit(
                          _habitDataList[index], mainScreenController.listHabitProcess[i]);
                    }
                  },
                ),
              )
            : Center(
                child: SpinKitFadingCube(
                  color: AppColors.cFFFF,
                ),
              )
        : NoneHabitDisplayWidget();
  }

  /// [Tab widget]
  Widget _mainScreenDateTimeTab(String title) {
    return Tab(
      child: Container(
        width: Get.width * 0.25,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget swipeHabit(Habit habit, Process process) {
    return SwipeActionCell(
      backgroundColor: AppColors.c0000,
      key: ObjectKey(habit),
      leadingActions: [
        SwipeAction(
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cFF4C,
            ),
            child: Center(
              child: Text(
                'Done',
              ),
            ),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.result = mainScreenController.updateHabitProcess(
              habit: habit,
            );
            mainScreenController.updateProcess(process);
            print('done');
            setState(() {});
          },
          color: AppColors.c0000,
        ),
        if (habit.isSetGoal)
          SwipeAction(
            content: Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.cFFFE,
              ),
              child: Center(child: Text('+1')),
            ),
            onTap: (CompletionHandler handler) async {
              handler(false);
              process.result++;
              mainScreenController.updateProcess(process);
              print('1');
              setState(() {});
            },
            color: AppColors.c0000,
          ),
      ],
      trailingActions: [
        SwipeAction(
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cFFFE,
            ),
            child: Center(child: Text('Skip')),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.isSkip = true;
            mainScreenController.updateProcess(process);
            print('Skip');
            setState(() {});
          },
          color: AppColors.c0000,
        ),
      ],
      child: habitTile(
          habit,
          mainScreenController.listHabitProcess
              .indexWhere((element) => element.habitId == process.habitId)),
    );
  }

  Widget swipeRightHabit(Habit habit, Process process) {
    return SwipeActionCell(
      backgroundColor: AppColors.c0000,
      key: ObjectKey(habit),
      trailingActions: [
        SwipeAction(
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cFF9C,
            ),
            child: Center(
              child: Text('Note'),
            ),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.isSkip = true;
            _moveToHabitNoteScreen(habit);
            print('Note');
            setState(() {});
          },
          color: AppColors.c0000,
        ),
        SwipeAction(
          content: Container(
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.cFFFF98,
            ),
            child: Center(child: Text('Undo')),
          ),
          onTap: (CompletionHandler handler) async {
            handler(false);
            process.isSkip = false;
            process.result = 0;
            mainScreenController.updateProcess(process);
            print('Undo');
            setState(() {});
          },
          color: AppColors.c0000,
        ),
      ],
      child: habitTile(
        habit,
        mainScreenController.listHabitProcess
            .indexWhere((element) => element.habitId == process.habitId),
      ),
    );
  }

  Widget habitTile(Habit habit, int index) {
    return Obx(() {
      bool isSkiped = mainScreenController.listHabitProcess[index].isSkip;
      bool isCompleted = mainScreenController.listHabitProcess[index].result == habit.amount &&
          mainScreenController.listHabitProcess[index].result > 0;
      bool isNotSetGoalAndCompleted = mainScreenController.listHabitProcess[index].result == -1;
      return GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration:
              BoxDecoration(color: AppColors.cFF2F, borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                // icon
                padding: EdgeInsets.all(20),
                child: Icon(
                  IconData(habit.icon, fontFamily: 'MaterialIcons'),
                  size: 50,
                  color: isSkiped || isCompleted || isNotSetGoalAndCompleted
                      ? AppColors.cFF9E
                      : Color(int.parse(habit.color, radix: 16)),
                ),
              ),
              Expanded(
                // tên
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        habit.habitName,
                        style: TextStyle(
                          fontSize: 22,
                          decoration: isCompleted || isNotSetGoalAndCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                        maxLines: 2,
                      ),
                      if (isSkiped)
                        Text(
                          'Skipped',
                          style: TextStyle(
                              color: AppColors.cFFFE, fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      if (isCompleted || isNotSetGoalAndCompleted)
                        Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 18,
                              color: AppColors.cFF11,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '11 day streak !!',
                              style: TextStyle(color: AppColors.cFF11, fontSize: 16),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
              if (habit.isSetGoal)
                Padding(
                  // process
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        mainScreenController.listHabitProcess[index].result.toString() +
                            '/' +
                            habit.amount.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            int.parse(habit.color, radix: 16),
                          ),
                        ),
                      ),
                      Text(
                        habit.unit,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
        onTap: () => _moveToHabitStatisticScreen(habit),
      );
    });
  }

  @override
  void openOrCloseSideMenu(GlobalKey<SideMenuState> key) {
    if (key.currentState.isOpened)
      key.currentState.closeSideMenu();
    else
      key.currentState.openSideMenu();
  }

  /// Navigation
  void _moveToHabitStatisticScreen(Habit habit) {
    Get.toNamed(
      Routes.STATISTIC,
      arguments: habit,
    );
  }

  void _moveToHabitNoteScreen(Habit habit) {
    Get.toNamed(
      Routes.NOTE,
      arguments: [
        habit.habitId,
        mainScreenController.selectedDay.value,
      ],
    );
  }
}
