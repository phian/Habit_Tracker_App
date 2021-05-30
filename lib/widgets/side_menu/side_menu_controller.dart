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
    var currentLoginType = pref.getString(AppConstants.currentLoginType);

    if (currentLoginType != null && currentLoginType.isNotEmpty) {
      switch (currentLoginType) {
        case "google":
          userName.value = pref.getString(AppConstants.googleUserNameKey);
          imagePath.value = pref.getString(AppConstants.googleUserPhotoURLKey);
          break;
        case "facebook":
          userName.value = pref.getString(AppConstants.facebookUserNameKey);
          imagePath.value =
              pref.getString(AppConstants.facebookUserPhotoURLKey);
          break;
        case "apple":
          break;
      }
    }
  }

  Future<void> signOutUserAccount() async {
    var pref = await _preferenceService.getPref();
    var currentLoginType = pref.getString(AppConstants.currentLoginType);

    switch (currentLoginType) {
      case "google":
        await _googleSignOut();
        break;
      case "facebook":
        await _facebookSignOut();
        break;
      case "apple":
        break;
    }

    removeUserInfo();
  }

  Future<void> _googleSignOut() async {
    await _apiService.googleSignOut().catchError(
          (err) => print(
            err.toString(),
          ),
        );
  }

  Future<void> _facebookSignOut() async {
    await _apiService.facebookSignOut().catchError(
          (err) => print(
            err.toString(),
          ),
        );
  }

  void removeUserInfo() async {
    var pref = await _preferenceService.getPref();
    var currentLoginType = pref.getString(AppConstants.currentLoginType);

    switch (currentLoginType) {
      case "google":
        pref.setString(AppConstants.googleUserNameKey, "User");
        pref.setString(AppConstants.googleUserPhotoURLKey, "");
        pref.setString(AppConstants.currentLoginType, "");
        break;
      case "facebook":
        pref.setString(AppConstants.facebookUserNameKey, "User");
        pref.setString(AppConstants.facebookUserPhotoURLKey, "");
        pref.setString(AppConstants.currentLoginType, "");
        break;
      case "apple":
        break;
    }

    userName.value = "User";
    imagePath.value = "";
  }
}
