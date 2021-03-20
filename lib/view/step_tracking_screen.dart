import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/step_tracking_screen_controller.dart';
import 'package:habit_tracker/widgets/side_menu.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepTackingScreen extends StatelessWidget {
  final StepTrackingScreenController _controller = StepTrackingScreenController();

  final GlobalKey<SideMenuState> _stepTrackingScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "StepTrackingScreenKey",
  );
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenMenu(
      menuKey: _stepTrackingScreenKey,
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
            color: Colors.white,
          ),
          onPressed: () {
            final _state = _stepTrackingScreenKey.currentState;
            if (_state.isOpened)
              _state.closeSideMenu();
            else
              _state.openSideMenu();
          },
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFF2B2B2B),
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
                        color: Colors.black12,
                        child: TabBar(
                          onTap: (index) {
                            switch (index) {
                              case 0:
                                _controller.changeSelectedTabIndex(index);
                                _controller.changeTrackingData(
                                  index: 0,
                                  currentData: "Today",
                                  timeData: "1h19m",
                                  caloriesData: '603',
                                  distanceData: "2.11",
                                  totalSteps: "500",
                                  goalSteps: 600,
                                );
                                break;
                              case 1:
                                _controller.changeSelectedTabIndex(index);
                                _controller.changeTrackingData(
                                  index: 1,
                                  currentData: "Week",
                                  timeData: "14h30m",
                                  caloriesData: '5000',
                                  distanceData: "15",
                                  totalSteps: "3500",
                                  goalSteps: 4000,
                                );
                                break;
                              case 2:
                                _controller.changeSelectedTabIndex(index);
                                _controller.changeTrackingData(
                                  index: 2,
                                  currentData: "Month",
                                  timeData: "60h50m",
                                  caloriesData: '18000',
                                  distanceData: "100",
                                  totalSteps: "15000",
                                  goalSteps: 16000,
                                );
                                break;
                            }
                          },
                          isScrollable: true,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white24,
                          indicatorColor: Colors.transparent,
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
                  color: Colors.white24,
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
                        color: Color(0xFF1C8EFE),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      alignment: Alignment.center,
                      child: Obx(
                        () => Text(
                          _controller.cuurentData.value,
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
              color: Color(0xFF2F313E),
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
                                  color: Color(0xFFFABB37),
                                ),
                              ),
                            ),
                            Text(
                              " Steps",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xFFFABB37),
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
                                color: Color(0xFFA7AAB1),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Obx(
                              () => Text(
                                _controller.goalSteps.value.toString(),
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFE7352),
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
                              swapAnimationDuration:
                                  Duration(milliseconds: 250),
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
                color: Color(0xFFA7AAB1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Biểu đồ tròn cho ngày]
  Widget _dayChart() {
    return Container(
      width: Get.width * 0.7,
      height: Get.width * 0.6,
      transform: Matrix4.translationValues(0.0, -5.0, 0.0),
      child: CircularStepProgressIndicator(
        totalSteps: 100,
        currentStep: (int.parse(_controller.totalSteps.value) /
                _controller.goalSteps.value *
                100)
            .toInt(),
        stepSize: 10,
        selectedColor: Colors.greenAccent,
        unselectedColor: Colors.grey[200],
        padding: 0,
        selectedStepSize: 15,
        roundedCap: (_, __) => true,
        child: Stack(
          children: [
            Center(
              child: Text(
                "Progress: " +
                    (int.parse(_controller.totalSteps.value) /
                            _controller.goalSteps.value *
                            100)
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
    );
  }

  /// [Main Bar data]
  BarChartData _weekChart(int data) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
              }
              return BarTooltipItem(
                weekDay + '\n' + (rod.y.toInt() * 100).toString() + " steps",
                TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              );
            }),
        touchCallback: (barTouchResponse) {
          if (barTouchResponse.spot != null &&
              barTouchResponse.touchInput is! FlPanEnd &&
              barTouchResponse.touchInput is! FlLongPressEnd) {
            _controller
                .changeTouchedIndex(barTouchResponse.spot.touchedBarGroupIndex);
          } else {
            _controller.changeTouchedIndex(-1);
          }
        },
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
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
                break;
              default:
                return '';
            }
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
  List<BarChartGroupData> _showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return _makeGroupData(0, 5,
                isTouched: i == _controller.touchedIndex.value);
          case 1:
            return _makeGroupData(1, 6.5,
                isTouched: i == _controller.touchedIndex.value);
          case 2:
            return _makeGroupData(2, 5,
                isTouched: i == _controller.touchedIndex.value);
          case 3:
            return _makeGroupData(3, 7.5,
                isTouched: i == _controller.touchedIndex.value);
          case 4:
            return _makeGroupData(4, 9,
                isTouched: i == _controller.touchedIndex.value);
          case 5:
            return _makeGroupData(5, 11.5,
                isTouched: i == _controller.touchedIndex.value);
          case 6:
            return _makeGroupData(6, 6.5,
                isTouched: i == _controller.touchedIndex.value);
          case 7:
            return _makeGroupData(6, 6.5,
                isTouched: i == _controller.touchedIndex.value);
            break;
          default:
            return null;
        }
      });

  /// [Tạo data cho Bar Chart, phần hiển thị khi người dùng chạm vào cột, x và y là data]
  BarChartGroupData _makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y, // Zoom cột
          colors: isTouched ? [Color(0xFF1C8EFE)] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Colors.white24],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  /// [Chart cho tháng]
  LineChartData _monthChart() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 13),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1),
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
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors
                .map(
                  (color) => color.withOpacity(0.3),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
