import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/constants/app_images.dart';
import 'package:intl/intl.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class AppConstants {
  static final GlobalKey mainScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "MainScreenKey",
  );
  static final GlobalKey<SideMenuState> allHabitScreenKey =
      GlobalKey<SideMenuState>(debugLabel: "AllHabitScreenKey");
  static final GlobalKey<SideMenuState> challengeScreenKey =
      GlobalKey<SideMenuState>(
    debugLabel: "ChallengeScreenKey",
  );
  static final GlobalKey<SideMenuState> stepTrackingScreenKey =
      GlobalKey<SideMenuState>(
    debugLabel: "StepTrackingScreenKey",
  );

  static const googleUserNameKey = "GOOGLE_USER_NAME_KEY";
  static const googleUserPhotoURLKey = "GOOGLE_USER_PHOTO_KEY";
  static const facebookUserNameKey = "FACEBOOK_USER_NAME_KEY";
  static const facebookUserPhotoURLKey = "FACEBOOK_USER_PHOTO_KEY";

  static final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
}

enum AllNoteLoadingState {
  isLoading,
  noDataAvailable,
  isLoaded,
}

/// Login type
enum LoginType {
  google,
  facebook,
  apple,
}

extension LoginTypeData on LoginType {
  String get loginTypeText {
    switch (this) {
      case LoginType.google:
        return "Sign in with Google";
      case LoginType.facebook:
        return "Sign in ith Facebook";
      case LoginType.apple:
        return "Sign in with Apple";
      default:
        return "Sign in with Apple";
    }
  }

  String get loginTypeIcon {
    switch (this) {
      case LoginType.google:
        return AppImages.icGoogle;
      case LoginType.facebook:
        return AppImages.icFacebook;
      case LoginType.apple:
        return AppImages.icApple;
      default:
        return AppImages.icApple;
    }
  }
}
