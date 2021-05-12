import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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
      _saveUserData(user);
    }

    return user;
  }

  Future<FacebookLoginStatus> signInWithFacebook() async {
    var facebookStatus = await apiService.signInWithFacebook();
    return facebookStatus;
  }

  void _saveUserData(var data) async {
    var pref = await _preferenceService.getPref();
    if (data is User) {
      pref.setString(
        AppConstants.googleUserNameKey,
        apiService.currentGoogleUser.displayName,
      );
      pref.setString(
        AppConstants.googleUserPhotoURLKey,
        apiService.currentGoogleUser.photoURL,
      );
    }
  }
}
