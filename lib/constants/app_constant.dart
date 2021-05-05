import 'package:flutter/cupertino.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';



class AppConstants {
  static final String imagePath = "assets/";

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

  
}

enum AllNoteLoadingState {
  isLoading,
  noDataAvailable,
  isLoaded,
}
