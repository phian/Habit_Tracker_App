import 'package:get/get.dart';

class StepTrackingScreenController extends GetxController {
  var touchedIndex = (-1).obs;
  var cuurentData = "Today".obs;
  var timeData = "1h19m".obs;
  var caloriesData = "603".obs;
  var distanceData = "2.11".obs;
  var totalSteps = "500".obs;
  var goalSteps = 600.obs;
  var selectedTabIndex = 0.obs;

  var _selectedIndex = 0;

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

      this.cuurentData.value = this.cuurentData.value != currentData
          ? currentData
          : this.cuurentData.value;

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
          : this.cuurentData.value;
    }
  }
}
