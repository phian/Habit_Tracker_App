import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';
import 'package:habit_tracker/view/genaral_screeen.dart';
import 'package:habit_tracker/view/notification_screen.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';

import '../model/habit.dart';
import 'habit_statistic_screen.dart';
import 'login_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreenController _mainScreenController = Get.put(MainScreenController());

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  AllHabitController allHabitController = Get.put(AllHabitController());

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
          "Today",
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

  /// [Body]
  Widget _mainScreenBody() {
    return Container(
      height: Get.height,
      child: Column(
        children: [
          Obx(
            // calendar
            () => Container(
              color: Colors.black12,
              padding: const EdgeInsets.only(top: 11, bottom: 11),
              child: FlutterDatePickerTimeline(
                startDate: DateTime.now().subtract(Duration(days: 14)),
                endDate: DateTime.now().add(Duration(days: 10000)),
                initialSelectedDate: _mainScreenController.selectedDay.value,
                onSelectedDateChange: (DateTime dateTime) {
                  _mainScreenController.changeSelectedDay(dateTime);
                  allHabitController.getHabitByWeekDate(dateTime.weekday);
                },
                selectedItemBackgroundColor: Colors.white24,
                selectedItemTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                unselectedItemBackgroundColor: Colors.transparent,
                unselectedItemTextStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => DefaultTabController(
                length: 4, // length of tabs
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      color: Colors.black12,
                      child: TabBar(
                        isScrollable: true,
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.white24,
                        indicatorColor: Colors.transparent,
                        physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        tabs: [
                          _mainScreenDateTimeTab('All day'),
                          _mainScreenDateTimeTab('Morning'),
                          _mainScreenDateTimeTab('Afternoon'),
                          _mainScreenDateTimeTab('Evening'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          children: <Widget>[
                            _listHabit(allHabitController.listAnytimeHabit),
                            _listHabit(allHabitController.listMorningHabit),
                            _listHabit(allHabitController.listAfternoonHabit),
                            _listHabit(allHabitController.listEveningHabit),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Widget hiển thị khi ko có habit náo trong database]
  Widget _noneHabitDisplayWidget() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/plant_pot.png",
                width: Get.width * 0.27,
                height: Get.height * 0.27,
              ),
              Text(
                "All tree grown.\nPlant new by clicking \"+\" button",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// [Build menu]
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

  /// [Widget cho menu]
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
          } else if (icon == Icons.settings) {
            Get.to(
              GeneralScreen(),
              transition: Transition.fadeIn,
            );
          } else {
            Get.to(
              LoginScreen(),
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

  /// [Habit list]
  Widget _listHabit(List _habitDataList) {
    return _habitDataList.length > 0
        ? ListView.separated(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            itemCount: _habitDataList.length,
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 10),
            itemBuilder: (BuildContext context, int index) {
              return habitTile(_habitDataList[index]);
            },
          )
        : _noneHabitDisplayWidget();
  }

  /// [Tab widget]
  Widget _mainScreenDateTimeTab(String title) {
    return Tab(
      child: Container(
        width: Get.width,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget habitTile(Habit habit) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Color(0xFF2F313E), borderRadius: BorderRadius.circular(15)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                IconData(habit.icon, fontFamily: 'MaterialIcons'),
                size: 50,
                color: Color(
                  int.parse(
                    habit.mau,
                    radix: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  habit.ten,
                  style: TextStyle(
                    fontSize: 22,
                    //fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
              ),
            ),
            habit.batMucTieu == 0
                ? Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        //SizedBox(height: 20),
                        Text(
                          '0/' + habit.soLan.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Color(int.parse(habit.mau, radix: 16))),
                        ),
                        Text(
                          habit.donVi,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      onTap: () {
        Get.to(HabitStatisticScreen(), arguments: habit);
      },
    );
  }
}
