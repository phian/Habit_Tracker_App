import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/step_tracking_screen_controller.dart';

class WeeklyChart {
  final StepTrackingScreenController controller;

  WeeklyChart({@required this.controller});

  BarChartData weekChart(int data) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppColors.cFF60,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay = controller.initWeekDate(group.x.toInt());
              return BarTooltipItem(
                weekDay + '\n' + (rod.y.toInt() * 100).toString() + " steps",
                TextStyle(
                  color: AppColors.cFFFF,
                  fontSize: 18.0,
                ),
              );
            }),
        touchCallback: (barTouchResponse) =>
            controller.onChartBarTouchResponse(barTouchResponse),
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
            return controller.initWeekColumnText(value.toInt());
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
          return controller.initBarChartGroupDataList(i);
        },
      );
}
