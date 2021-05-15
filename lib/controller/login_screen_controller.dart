import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/service/api_service/api_service.dart';
import 'package:habit_tracker/service/database/shared_preference_service.dart';

class LoginScreenController extends GetxController {
  APIService apiService = APIService.instance;
  SharedPreferenceService _preferenceService = SharedPreferenceService.instance;

  var isLoginOrSignup = 1.obs;
  var isLoginVisible = true.obs;
  var isSignUpVisible = false.obs;

  changeIsLogin(int index) {
    if (isLoginOrSignup.value != index) isLoginOrSignup.value = index;
  }

  changeLoginOrSignUpFormView() {
    isSignUpVisible.value = !isSignUpVisible.value;
  }

  Future<User> signInWithGoogle() async {
    var user = await apiService.signInWithGoogle();
    if (user != null) {
      _saveUserData(LoginType.google);
    }

    return user;
  }

  Future<FacebookLoginStatus> signInWithFacebook() async {
    var facebookStatus = await apiService.signInWithFacebook();
    if (facebookStatus == FacebookLoginStatus.success) {
      _saveUserData(LoginType.facebook);
    }
    return facebookStatus;
  }

  void _saveUserData(LoginType type) async {
    var pref = await _preferenceService.getPref();
    switch (type) {
      case LoginType.google:
        pref.setString(
          AppConstants.googleUserNameKey,
          apiService.googleUser.displayName,
        );
        pref.setString(
          AppConstants.googleUserPhotoURLKey,
          apiService.googleUser.photoURL,
        );
        break;
      case LoginType.facebook:
        var userProfileName = await apiService.getFacebookUserProfileName();
        var userPhoto = await apiService.getFacebookUserPhotoURL();
        pref.setString(
          AppConstants.facebookUserNameKey,
          userProfileName,
        );
        pref.setString(
          AppConstants.facebookUserPhotoURLKey,
          userPhoto,
        );

        break;
      case LoginType.apple:
        break;
    }
  }
}
