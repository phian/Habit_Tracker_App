import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/view/main_screen/widgets/habit_tile.dart';
import 'package:habit_tracker/widgets/none_habit_display.dart';
import 'package:habit_tracker/widgets/side_menu/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../model/habit.dart';

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
              initialFocusedDate: mainScreenController.selectedDate.value,
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
                      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            !mainScreenController.isLoading.value
                                ? _listHabit(mainScreenController.listAnytimeHabit)
                                : NoneHabitDisplayWidget(),
                            !mainScreenController.isLoading.value
                                ? _listHabit(mainScreenController.listMorningHabit)
                                : NoneHabitDisplayWidget(),
                            !mainScreenController.isLoading.value
                                ? _listHabit(mainScreenController.listAfternoonHabit)
                                : NoneHabitDisplayWidget(),
                            !mainScreenController.isLoading.value
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
  Widget _listHabit(List<Habit> listHabit) {
    return listHabit.length > 0
        ? ListView.separated(
            key: UniqueKey(),
            padding: EdgeInsets.symmetric(vertical: 16),
            itemCount: listHabit.length,
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              int i = mainScreenController.listProcessByDay.indexWhere(
                (e) => e.habitId == listHabit[index].habitId,
              );

              return SwipeHabitTile(
                habit: listHabit[index],
                process: i != -1 ? mainScreenController.listProcessByDay[i] : null,
              );
            },
          )
        : NoneHabitDisplayWidget();
  }

  /// [Tab bar widget]
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

  @override
  void openOrCloseSideMenu(GlobalKey<SideMenuState> key) {
    if (key.currentState.isOpened)
      key.currentState.closeSideMenu();
    else
      key.currentState.openSideMenu();
  }
}
