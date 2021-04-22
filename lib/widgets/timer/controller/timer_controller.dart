import 'package:get/get.dart';

class TimerController extends GetxController {
  var isStarted = false.obs;
  var isPaused = true.obs;
  var isStopped = true.obs;

  void onBegin() {
    isStarted.value = true;
    isPaused.value = false;
    isStopped.value = false;
  }

  void onPause() {
    isPaused.value = true;
    isStarted.value = false;
  }

  void onStop() {
    isStarted.value = false;
    isPaused.value = true;
    isStopped.value = true;
  }
}
