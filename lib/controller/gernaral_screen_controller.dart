import 'package:get/get.dart';
import 'package:habit_tracker/view/view_variables/general_screen_variables.dart';

class GeneralScreenController extends GetxController {
  var isOcIconBadge = true.obs;
  var isMinimalistInterface = false.obs;
  var isVacationMode = false.obs;
  var isOnSound = true.obs;
  var isPassCodeLock = false.obs;

  GeneralScreenVariables variables;

  GeneralScreenController() {
    initListItems();
  }

  void changeSwitchData(String title) {
    switch (title.toLowerCase()) {
      case 'icon badge':
        onOrOffSwitch(0);
        break;
      case 'minimalist interface':
        onOrOffSwitch(1);
        break;
      case 'vacation mode':
        onOrOffSwitch(2);
        break;
      case 'sounds':
        onOrOffSwitch(3);
        break;
      case 'passcode lock':
        onOrOffSwitch(4);
        break;
    }
  }

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

  void initListItems() {
    variables = GeneralScreenVariables(
      controller: this,
      toggles: [
        null,
        null,
        isOcIconBadge,
        isMinimalistInterface,
        isVacationMode,
        null,
        isOnSound,
        null,
        isPassCodeLock,
        null,
        null,
      ],
    );
    variables.initData();
  }
}
