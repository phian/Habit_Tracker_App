import 'package:get/get.dart';

class TimerController extends GetxController {
  var canStart = true.obs;
  var canReset = false.obs;

  void onBegin() {
    canStart.value = false;
    canReset.value = true;
  }

  void onPause() {
    canStart.value = true;
    canReset.value = true;
  }

  void onStop() {
    canStart.value = true;
    canReset.value = false;
  }
}
