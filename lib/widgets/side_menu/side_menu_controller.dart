import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/sns_models/facebook_sns_model.dart';
import 'package:habit_tracker/service/api_service/api_service.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

class SideMenuController extends GetxController {
  SharedPreferenceService _preferenceService = SharedPreferenceService.instance;
  var facebookUser = FacebookUserModel().obs;
  var userName = "User".obs;
  var imagePath = "".obs;
  APIService _apiService = APIService.instance;

  SideMenuController() {
    initUserInfo();
  }

  void initUserInfo() async {
    var pref = await _preferenceService.getPref();
    if (pref.getString(AppConstants.googleUserNameKey) != null &&
        pref.getString(AppConstants.googleUserPhotoURLKey) != null) {
      userName.value = pref.getString(AppConstants.googleUserNameKey);
      imagePath.value = pref.getString(AppConstants.googleUserPhotoURLKey);
    }
    if (pref.getString(AppConstants.facebookUserNameKey) != null &&
        pref.getString(AppConstants.facebookUserPhotoURLKey) != null) {
      userName.value = pref.getString(AppConstants.facebookUserNameKey);
      imagePath.value = pref.getString(AppConstants.facebookUserPhotoURLKey);
    }
  }

  Future<void> signOutUserAccount() async {
    var pref = await _preferenceService.getPref();
    if (pref.getString(AppConstants.googleUserNameKey) != null &&
        pref.getString(AppConstants.googleUserPhotoURLKey) != null) {
      await _googleSignOut();
    } else if (pref.getString(AppConstants.facebookUserNameKey) != null &&
        pref.getString(AppConstants.facebookUserPhotoURLKey) != null) {
      await _facebookSignOut();
    }
  }

  Future<void> _googleSignOut() async {
    await _apiService.googleSignOut().catchError(
          (err) => print(
            err.toString(),
          ),
        );
    removeUserInfo();
  }

  Future<void> _facebookSignOut() async {
    await _apiService.facebookSignOut().catchError(
          (err) => print(
            err.toString(),
          ),
        );
    removeUserInfo();
  }

  void removeUserInfo() async {
    var pref = await _preferenceService.getPref();
    if (pref.getString(AppConstants.googleUserNameKey) != null &&
        pref.getString(AppConstants.googleUserPhotoURLKey) != null) {
      pref.setString(AppConstants.googleUserNameKey, "User");
      pref.setString(AppConstants.googleUserPhotoURLKey, "");

      userName.value = "User";
      imagePath.value = "";
    }
    if (pref.getString(AppConstants.facebookUserNameKey) != null &&
        pref.getString(AppConstants.facebookUserPhotoURLKey) != null) {
      pref.setString(AppConstants.facebookUserNameKey, "User");
      pref.setString(AppConstants.facebookUserPhotoURLKey, "");

      userName.value = "User";
      imagePath.value = "";
    }
  }
}
