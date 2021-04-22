import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/api_service/api_service.dart';

class LoginScreenController extends GetxController {
  APIService apiService = APIService();

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
    return await apiService.signInWithGoogle();
  }

  Future<FacebookLoginStatus> signInWithFacebook() async {
    return await apiService.signInWithFacebook();
  }
}
