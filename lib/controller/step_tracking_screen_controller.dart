import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

class StepTrackingScreenController extends GetxController {
  var touchedIndex = (-1).obs;
  var currentData = "Today".obs;
  var timeData = "1h19m".obs;
  var caloriesData = "603".obs;
  var distanceData = "2.11".obs;
  var totalSteps = "0".obs;
  var goalSteps = 0.obs;
  var selectedTabIndex = 0.obs;
  var _selectedIndex = 0;

  SharedPreferenceService _sharedPrefService = SharedPreferenceService.instance;

  changeTouchedIndex(int index) {
    if (index != touchedIndex.value) {
      touchedIndex.value = index;
    }
  }

  changeSelectedTabIndex(int index) {
    if (index != selectedTabIndex.value) {
      selectedTabIndex.value = index;
    }
  }

  changeTrackingData({
    int index,
    String currentData,
    String timeData,
    String caloriesData,
    String distanceData,
    String totalSteps,
    int goalSteps,
  }) {
    if (_selectedIndex != index) {
      _selectedIndex = index;

      this.currentData.value = this.currentData.value != currentData
          ? currentData
          : this.currentData.value;

      this.timeData.value =
          this.timeData.value != timeData ? timeData : this.timeData.value;

      this.caloriesData.value = this.caloriesData.value != caloriesData
          ? caloriesData
          : this.caloriesData.value;

      this.distanceData.value = this.distanceData.value != distanceData
          ? distanceData
          : this.distanceData.value;

      this.totalSteps.value = this.totalSteps.value != totalSteps
          ? totalSteps
          : this.totalSteps.value;

      this.goalSteps.value = this.goalSteps.value != goalSteps
          ? goalSteps
          : this.currentData.value;
    }
  }

  void changeTabAndTrackingData(int index) {
    switch (index) {
      case 0:
        changeSelectedTabIndex(index);
        changeTrackingData(
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
        changeSelectedTabIndex(index);
        changeTrackingData(
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
        changeSelectedTabIndex(index);
        changeTrackingData(
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
  }

  /// [Week chart]
  String initWeekDate(int i) {
    switch (i) {
      case 0:
        return 'Monday';
        break;
      case 1:
        return 'Tuesday';
        break;
      case 2:
        return 'Wednesday';
        break;
      case 3:
        return 'Thursday';
        break;
      case 4:
        return 'Friday';
        break;
      case 5:
        return 'Saturday';
        break;
      default:
        return 'Sunday';
        break;
    }
  }

  String initWeekColumnText(int value) {
    switch (value) {
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
  }

  /// [Chart group data]
  BarChartGroupData initBarChartGroupDataList(int i) {
    switch (i) {
      case 0:
        return makeGroupData(0, 5, isTouched: i == touchedIndex.value);
      case 1:
        return makeGroupData(1, 6.5, isTouched: i == touchedIndex.value);
      case 2:
        return makeGroupData(2, 5, isTouched: i == touchedIndex.value);
      case 3:
        return makeGroupData(3, 7.5, isTouched: i == touchedIndex.value);
      case 4:
        return makeGroupData(4, 9, isTouched: i == touchedIndex.value);
      case 5:
        return makeGroupData(5, 11.5, isTouched: i == touchedIndex.value);
      case 6:
        return makeGroupData(6, 6.5, isTouched: i == touchedIndex.value);
      case 7:
        return makeGroupData(6, 6.5, isTouched: i == touchedIndex.value);
        break;
      default:
        return null;
    }
  }

  BarChartGroupData makeGroupData(
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

  void onChartBarTouchResponse(BarTouchResponse barTouchResponse) {
    if (barTouchResponse.spot != null &&
        barTouchResponse.touchInput is! FlPanEnd &&
        barTouchResponse.touchInput is! FlLongPressEnd) {
      changeTouchedIndex(barTouchResponse.spot.touchedBarGroupIndex);
    } else {
      changeTouchedIndex(-1);
    }
  }

  /// [Month chart]
  String initMonthChartText(int value) {
    switch (value) {
      case 2:
        return 'MAR';
      case 5:
        return 'JUN';
      case 8:
        return 'SEP';
      default:
        return '';
        break;
    }
  }

  String initMonthChartValue(int value) {
    switch (value) {
      case 1:
        return '10k';
      case 3:
        return '30k';
      case 5:
        return '50k';
      default:
        return '';
    }
  }

  Future<int> getStepsValue(String key) async {
    var pref = await _sharedPrefService.getPref();
    return pref.getInt(key);
  }

  void saveStepsValue(var key, int value) async {
    var pref = await _sharedPrefService.getPref();
    pref.setInt(key, value);
  }

  void updateTotalSteps(int newSteps) {
    totalSteps.value = newSteps.toString();
  }

  void updateGoalSteps(int currentSteps) {
    /// Calculate how many time does the current step larger than 100
    /// and multiple that value with 100 and add 100 more steps for new goal
    goalSteps.value = (currentSteps ~/ 100) * 100 + 100;
  }
}
