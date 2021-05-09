import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/constants/app_images.dart';
import 'package:habit_tracker/controller/step_tracking_screen_controller.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/view/step_tracking_screen/widgets/daily_chart.dart';
import 'package:habit_tracker/view/step_tracking_screen/widgets/monthly_chart.dart';
import 'package:habit_tracker/view/step_tracking_screen/widgets/weekly_chart.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class StepTackingScreen extends StatefulWidget {
  @override
  _StepTackingScreenState createState() => _StepTackingScreenState();
}

class _StepTackingScreenState extends State<StepTackingScreen>
    implements SideMenuModel {
  final _controller = Get.find<StepTrackingScreenController>();
  WeeklyChart _weeklyChart;
  MonthlyChart _monthlyChart;

  /// Step keys
  var _savedStepsCountKey = "saved_steps";
  var _lastDaySavedKey = "last_day_steps";

  @override
  void initState() {
    super.initState();
    _weeklyChart = WeeklyChart(controller: _controller);
    _monthlyChart = MonthlyChart(controller: _controller);
    _startStepListening();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: AppConstants.stepTrackingScreenKey,
      child: Scaffold(
        appBar: _stepTrackingScreenAppBar(),
        body: _stepTrackingScreenBody(),
      ),
    );
  }

  /// [App Bar]
  Widget _stepTrackingScreenAppBar() {
    return AppBar(
      title: Text(
        "Step tracking",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            Icons.menu_rounded,
            size: 30.0,
            color: AppColors.cFFFF,
          ),
          onPressed: () => openOrCloseSideMenu(
            AppConstants.stepTrackingScreenKey,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cFF2B,
      elevation: 0.0,
    );
  }

  /// [Tab widget]
  Widget _stepTrackingScreenTab(String title) {
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

  /// [body]
  Widget _stepTrackingScreenBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 10.0),
                    color: AppColors.c1F00,
                    child: TabBar(
                      onTap: (index) =>
                          _controller.changeTabAndTrackingData(index),
                      isScrollable: true,
                      labelColor: AppColors.cFFFF,
                      unselectedLabelColor: AppColors.c3DFF,
                      indicatorColor: AppColors.c0000,
                      physics: NeverScrollableScrollPhysics(),
                      tabs: [
                        _stepTrackingScreenTab("Day"),
                        _stepTrackingScreenTab("Week"),
                        _stepTrackingScreenTab("Month"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          _stepTrackingView(),
                          _stepTrackingView(),
                          _stepTrackingView(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Tracking view]
  Widget _stepTrackingView() {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(30.0),
              width: Get.width * 0.5,
              height: Get.width * 0.5,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: AppColors.c3DFF,
                ),
                borderRadius: BorderRadius.circular(360.0),
              ),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppImages.imgRunning,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: Offset(0.0, Get.width * 0.4 * 0.21),
                      child: Container(
                        width: 80.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: AppColors.cFF1C,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        alignment: Alignment.center,
                        child: Obx(
                          () => Text(
                            _controller.currentData.value,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _trackingValueColumn(
                  amount: _controller.timeData,
                  title: "Time",
                ),
                _trackingValueColumn(
                  amount: _controller.caloriesData,
                  title: "Calories",
                ),
                _trackingValueColumn(
                  amount: _controller.distanceData,
                  title: "Distance",
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 70.0),
            decoration: BoxDecoration(
              color: AppColors.cFF2F,
              borderRadius: BorderRadius.circular(30.0),
            ),
            height: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Obx(
                        () => Text(
                          _controller.totalSteps.value,
                          style: TextStyle(
                            fontSize: 60.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.cFFFA,
                          ),
                        ),
                      ),
                      Text(
                        " Steps",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: AppColors.cFFFA,
                        ),
                      ).marginOnly(top: 20.0, left: 4.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Goal",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: AppColors.cFFA7,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Obx(
                              () => Text(
                                _controller.goalSteps.value.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.cFFFE,
                                ),
                              ),
                            ),
                          ],
                        ).paddingOnly(top: 11.0, left: 16.0),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      switch (_controller.selectedTabIndex.value) {
                        case 0:
                          return _dayChart();
                          break;
                        case 1:
                          return BarChart(
                            _weekChart(_controller.touchedIndex.value),
                            swapAnimationDuration: Duration(milliseconds: 250),
                          );
                          break;
                        default:
                          return Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: LineChart(
                              _monthChart(),
                            ),
                          );
                      }
                    },
                  ).paddingOnly(top: 16.0, bottom: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [Widget hiển thị các số liệu thống kê]
  Widget _trackingValueColumn({RxString amount, String title}) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title.toLowerCase() != "distance"
                ? amount.value
                : (amount.value + " km"),
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              color: AppColors.cFFA7,
            ),
          ),
        ],
      ),
    );
  }

  /// [Biểu đồ tròn cho ngày]
  Widget _dayChart() {
    return DailyChartWidget(
      totalSteps: int.parse(_controller.totalSteps.value),
      goalSteps: _controller.goalSteps.value,
    );
  }

  /// [Main Bar data]
  BarChartData _weekChart(int data) {
    return _weeklyChart.weekChart(data);
  }

  /// [Chart cho tháng]
  LineChartData _monthChart() {
    return _monthlyChart.monthChart();
  }

  @override
  void openOrCloseSideMenu(GlobalKey<SideMenuState> key) {
    if (key.currentState.isOpened)
      key.currentState.closeSideMenu();
    else
      key.currentState.openSideMenu();
  }

  /// Step calculate
  void _startStepListening() {
    Pedometer.stepCountStream.listen(
      _getTodaySteps,
      onError: _onError,
      onDone: _onDone,
      cancelOnError: true,
    );
  }

  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");

  void _getTodaySteps(StepCount stepCount) async {
    _checkStepValue(stepCount.steps);

    print(stepCount.steps);
    int savedStepsCount = await _controller.getStepsValue(_savedStepsCountKey);
    print("saved steps count value: $savedStepsCount");

    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    if (stepCount.steps < savedStepsCount) {
      // Upon device reboot, pedometer resets. When this happens, the saved counter must be reset as well.
      savedStepsCount = 0;
      // persist this value using a package of your choice here
      _controller.saveStepsValue(_savedStepsCountKey, savedStepsCount);
    }

    // load the last day saved using a package of your choice here
    int lastDaySaved = await _controller.getStepsValue(_lastDaySavedKey);
    print("last day saved value: $lastDaySaved");

    // When the day changes, reset the daily steps count
    // and Update the last day saved as the day changes.
    if (lastDaySaved < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = stepCount.steps;

      _controller
        ..saveStepsValue(_lastDaySavedKey, lastDaySaved)
        ..saveStepsValue(_savedStepsCountKey, savedStepsCount);
    }

    var todaySteps = stepCount.steps - savedStepsCount;
    _controller.saveStepsValue(todayDayNo, todaySteps);
    _controller.updateTotalSteps(todaySteps);
    _controller.updateGoalSteps(todaySteps);
  }

  void _checkStepValue(int stepCount) async {
    int savedStepsCount = await _controller.getStepsValue(_savedStepsCountKey);
    int lastDaySaved = await _controller.getStepsValue(_lastDaySavedKey);

    // Check if data is not create then create the initial value
    if (savedStepsCount == null) {
      _controller.saveStepsValue(_savedStepsCountKey, stepCount);
    }
    if (lastDaySaved == null) {
      _controller.saveStepsValue(
        _lastDaySavedKey,
        Jiffy(DateTime.now()).dayOfYear,
      );
    }
  }
}
