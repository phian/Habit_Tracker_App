import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/step_tracking_screen_controller.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepTackingScreen extends StatelessWidget implements SideMenuModel {
  final _controller = Get.find<StepTrackingScreenController>();

  final List<Color> _gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: AppConstant.stepTrackingScreenKey,
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
            AppConstant.stepTrackingScreenKey,
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
                      onTap: (index) => _controller.changeTabAndTrackingData(index),
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
                    alignment: Alignment.center,
                    child: Image.asset(
                      "images/running.png",
                      fit: BoxFit.contain,
                      width: Get.width * 0.4 * 0.8,
                      height: Get.width * 0.4 * 0.8,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      transform: Matrix4.translationValues(
                        0.0,
                        Get.width * 0.4 * 0.21,
                        0.0,
                      ),
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
            height: Get.height * 0.5,
            decoration: BoxDecoration(
              color: AppColors.cFF2F,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40.0),
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 60.0,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
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
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 11.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.cFFFE,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
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
                              width: Get.width * 0.95,
                              height: Get.height * 0.5 * 0.8,
                              child: LineChart(
                                _monthChart(),
                              ),
                            );
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
    );
  }

  /// [Widget hiển thị các số liệu thống kê]
  Widget _trackingValueColumn({RxString amount, String title}) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Text(
              title.toLowerCase() != "distance" ? amount.value : (amount.value + " km"),
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
      ),
    );
  }

  /// [Biểu đồ tròn cho ngày]
  Widget _dayChart() {
    return Transform.translate(
      offset: Offset(0.0, -5.0),
      child: Container(
        width: Get.width * 0.7,
        height: Get.width * 0.6,
        child: CircularStepProgressIndicator(
          totalSteps: 100,
          currentStep:
              (int.parse(_controller.totalSteps.value) / _controller.goalSteps.value * 100).toInt(),
          stepSize: 10,
          selectedColor: AppColors.cFF69,
          unselectedColor: AppColors.cFFEE,
          padding: 0,
          selectedStepSize: 15,
          roundedCap: (_, __) => true,
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Progress: " +
                      (int.parse(_controller.totalSteps.value) / _controller.goalSteps.value * 100)
                          .toString()
                          .substring(0, 2) +
                      " %",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [Main Bar data]
  BarChartData _weekChart(int data) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppColors.cFF60,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = _controller.initWeekDate(group.x.toInt());
              return BarTooltipItem(
                weekDay + '\n' + (rod.y.toInt() * 100).toString() + " steps",
                TextStyle(
                  color: AppColors.cFFFF,
                  fontSize: 18.0,
                ),
              );
            }),
        touchCallback: (barTouchResponse) => _controller.onChartBarTouchResponse(barTouchResponse),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          margin: 16,
          getTitles: (double value) {
            return _controller.initWeekColumnText(value.toInt());
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _showingGroups(),
    );
  }

  /// [Showing group]
  List<BarChartGroupData> _showingGroups() => List.generate(
        7,
        (i) {
          return _controller.initBarChartGroupDataList(i);
        },
      );

  /// [Chart cho tháng]
  LineChartData _monthChart() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.cFF37,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.cFF37,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
              const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 13),
          getTitles: (value) => _controller.initMonthChartText(value.toInt()),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) => _controller.initMonthChartValue(value.toInt()),
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: AppColors.cFF37, width: 1),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: _gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: _gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ],
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
