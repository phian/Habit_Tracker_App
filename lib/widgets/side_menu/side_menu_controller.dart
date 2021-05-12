import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/sns_models/facebook_sns_model.dart';
import 'package:habit_tracker/service/api_service/api_service.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

class SideMenuController extends GetxController {
  APIService _apiService;
  SharedPreferenceService _preferenceService = SharedPreferenceService.instance;
  var facebookUser = FacebookUserModel().obs;
  var userName = "User".obs;
  var imagePath = "".obs;

  SideMenuController() {
    _apiService = APIService.instance;
    initUserInfo();
  }

  void initUserInfo() async {
    var pref = await _preferenceService.getPref();
    if (pref.getString(AppConstants.googleUserNameKey) != null &&
        pref.getString(AppConstants.googleUserPhotoURLKey) != null) {
      userName.value = pref.getString(AppConstants.googleUserNameKey);
      imagePath.value = pref.getString(AppConstants.googleUserPhotoURLKey);
    } else {}
  }
}
