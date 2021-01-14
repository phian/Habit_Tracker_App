import 'package:get/get.dart';

class GeneralScreenController extends GetxController {
  var isOcIconBadge = true.obs;
  var isMinimalistInterface = false.obs;
  var isVacationMode = false.obs;
  var isOnSound = true.obs;
  var isPassCodeLock = false.obs;

  onOrOffSwitch(int index) {
    switch (index) {
      case 0:
        isOcIconBadge.value = !isOcIconBadge.value;
        break;
      case 1:
        isMinimalistInterface.value = !isMinimalistInterface.value;
        break;
      case 2:
        isVacationMode.value = !isVacationMode.value;
        break;
      case 3:
        isOnSound.value = !isOnSound.value;
        break;
      case 4:
        isPassCodeLock.value = !isPassCodeLock.value;
        break;
    }
  }
}
