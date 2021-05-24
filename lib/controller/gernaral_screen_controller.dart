import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

import '../view/general_screen/general_screen_variables.dart';

class GeneralScreenController extends GetxController {
  var isOnIconBadge = true.obs;
  var isVacationMode = false.obs;
  var isOnSound = true.obs;
  var isPasscodeLock = false.obs;

  ///
  var startWeekCurrentValue = "Auto".obs;
  var startWeekCurrentIndex = 0.obs;
  var unitsOfMeasureCurrentValue = "Imperial".obs;
  var unitsOfMeasureCurrentIndex = 0.obs;
  var notificationToneCurrentValue = "Ascending".obs;
  var notificationToneCurrentIndex = 0.obs;

  GeneralScreenVariables variables;

  SharedPreferenceService _preferenceService = SharedPreferenceService.instance;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void updateCurrentIndex(int index, GeneralItemType type) {
    switch (type) {
      case GeneralItemType.startWeekOn:
        startWeekCurrentIndex.value = index;
        break;
      case GeneralItemType.unitsOfMeasure:
        unitsOfMeasureCurrentIndex.value = index;
        break;
      case GeneralItemType.notificationTone:
        notificationToneCurrentIndex.value = index;
        break;
      default:
        return;
    }
  }

  void updateCurrentChoseValue(String value, GeneralItemType type) {
    switch (type) {
      case GeneralItemType.startWeekOn:
        startWeekCurrentValue.value = value;
        break;
      case GeneralItemType.unitsOfMeasure:
        unitsOfMeasureCurrentValue.value = value;
        break;
      case GeneralItemType.notificationTone:
        notificationToneCurrentValue.value = value;
        break;
      default:
        return;
    }

    _saveCurrentData(value, type);
  }

  void _saveCurrentData(String value, GeneralItemType type) async {
    var pref = await _preferenceService.getPref();
    switch (type) {
      case GeneralItemType.startWeekOn:
        pref.setString(AppConstants.startWeekOnKey, value);
        break;
      case GeneralItemType.unitsOfMeasure:
        pref.setString(AppConstants.unitOfMeasureKey, value);
        break;
      case GeneralItemType.notificationTone:
        pref.setString(AppConstants.notificationToneKey, value);
        break;
      default:
        return;
    }
  }

  ///
  void changeSwitchData(GeneralItemType type) async {
    switch (type) {
      case GeneralItemType.iconBadge:
        isOnIconBadge.value = !isOnIconBadge.value;
        _saveBoolItemData(type, isOnIconBadge.value);
        break;
      case GeneralItemType.vacationMode:
        isVacationMode.value = !isVacationMode.value;
        _saveBoolItemData(type, isVacationMode.value);
        break;
      case GeneralItemType.sounds:
        isOnSound.value = !isOnSound.value;
        _saveBoolItemData(type, isOnSound.value);
        break;
      case GeneralItemType.passCodeLock:
        isPasscodeLock.value = !isPasscodeLock.value;
        _saveBoolItemData(type, isPasscodeLock.value);
        break;
      default:
        break;
    }
  }

  void _saveBoolItemData(GeneralItemType type, bool value) async {
    var pref = await _preferenceService.getPref();

    switch (type) {
      case GeneralItemType.iconBadge:
        pref.setBool(AppConstants.iconBadgeKey, isOnIconBadge.value);
        break;
      case GeneralItemType.vacationMode:
        pref.setBool(AppConstants.vacationModeKey, isVacationMode.value);
        break;
      case GeneralItemType.sounds:
        pref.setBool(AppConstants.soundKey, isOnSound.value);
        break;
      case GeneralItemType.passCodeLock:
        pref.setBool(AppConstants.passcodeLockKey, isPasscodeLock.value);
        break;
      default:
        break;
    }
  }

  void initData() {
    initListItems();
    initChoiceData();
    initBooleanValues();
  }

  void initChoiceData() async {
    var pref = await _preferenceService.getPref();

    if (pref.getString(AppConstants.startWeekOnKey) != null) {
      startWeekCurrentValue.value = pref.getString(AppConstants.startWeekOnKey);
    } else {
      pref.setString(AppConstants.startWeekOnKey, startWeekCurrentValue.value);
      startWeekCurrentValue.value = pref.getString(AppConstants.startWeekOnKey);
    }

    if (pref.getString(AppConstants.unitOfMeasureKey) != null) {
      unitsOfMeasureCurrentValue.value =
          pref.getString(AppConstants.unitOfMeasureKey);
    } else {
      pref.setString(
          AppConstants.unitOfMeasureKey, unitsOfMeasureCurrentValue.value);
      unitsOfMeasureCurrentValue.value =
          pref.getString(AppConstants.unitOfMeasureKey);
    }

    if (pref.getString(AppConstants.notificationToneKey) != null) {
      notificationToneCurrentValue.value =
          pref.getString(AppConstants.notificationToneKey);
    } else {
      pref.setString(
          AppConstants.notificationToneKey, notificationToneCurrentValue.value);
      notificationToneCurrentValue.value =
          pref.getString(AppConstants.notificationToneKey);
    }
  }

  void initListItems() {
    variables = GeneralScreenVariables(
      controller: this,
    );
    variables.initData();
  }

  void initBooleanValues() async {
    var pref = await _preferenceService.getPref();

    /// Icon badge
    if (pref.getBool(AppConstants.iconBadgeKey) != null) {
      isOnIconBadge.value = pref.getBool(AppConstants.iconBadgeKey);
    } else {
      pref.setBool(AppConstants.iconBadgeKey, isOnIconBadge.value);
      isOnIconBadge.value = pref.getBool(AppConstants.iconBadgeKey);
    }

    /// Vacation mode
    if (pref.getBool(AppConstants.vacationModeKey) != null) {
      isVacationMode.value = pref.getBool(AppConstants.vacationModeKey);
    } else {
      pref.setBool(AppConstants.vacationModeKey, isVacationMode.value);
      isVacationMode.value = pref.getBool(AppConstants.vacationModeKey);
    }

    /// Sound
    if (pref.getBool(AppConstants.soundKey) != null) {
      isOnSound.value = pref.getBool(AppConstants.soundKey);
    } else {
      pref.setBool(AppConstants.soundKey, isOnSound.value);
      isOnSound.value = pref.getBool(AppConstants.soundKey);
    }

    /// Passcode lock
    if (pref.getBool(AppConstants.passcodeLockKey) != null) {
      isPasscodeLock.value = pref.getBool(AppConstants.passcodeLockKey);
    } else {
      pref.setBool(AppConstants.passcodeLockKey, isPasscodeLock.value);
      isPasscodeLock.value = pref.getBool(AppConstants.passcodeLockKey);
    }
  }

  String getCurrentValue(GeneralItemType type) {
    switch (type) {
      case GeneralItemType.startWeekOn:
        return startWeekCurrentValue.value;
      case GeneralItemType.unitsOfMeasure:
        return unitsOfMeasureCurrentValue.value;
      case GeneralItemType.notificationTone:
        return notificationToneCurrentValue.value;
      default:
        return "";
    }
  }

  void deleteAllHabit() {
    _databaseHelper.deleteAllHabit();
  }
}
