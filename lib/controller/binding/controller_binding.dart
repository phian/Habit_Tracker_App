import 'package:get/get.dart';
import 'package:habit_tracker/controller/challenges_screen_controller.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/controller/manage_screen_controller.dart';
import 'package:habit_tracker/controller/step_tracking_screen_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageScreenController());
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => ChallengesScreenController());
    Get.lazyPut(() => StepTrackingScreenController());
  }
}
