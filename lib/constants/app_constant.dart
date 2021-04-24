import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/view/all_habits_screen.dart';
import 'package:habit_tracker/view/challenges_screen.dart';
import 'package:habit_tracker/view/create_and_edit_habit_screen/create_habit_screen.dart';
import 'package:habit_tracker/view/create_and_edit_habit_screen/edit_habit_screen.dart';
import 'package:habit_tracker/view/general_screen/genaral_screeen.dart';
import 'package:habit_tracker/view/habit_all_note_screen/habit_all_note_screen.dart';
import 'package:habit_tracker/view/habit_categories_screen/habit_categories_screen.dart';
import 'package:habit_tracker/view/habit_category_list_screen/habit_category_list_screen.dart';
import 'package:habit_tracker/view/habit_note_screen.dart';
import 'package:habit_tracker/view/habit_statistic_screen.dart';
import 'package:habit_tracker/view/login_screen.dart';
import 'package:habit_tracker/view/main_screen.dart';
import 'package:habit_tracker/view/manage_screen.dart';
import 'package:habit_tracker/view/notification_screen.dart';
import 'package:habit_tracker/view/step_tracking_screen.dart';
import 'package:habit_tracker/widgets/timer/timer.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';



class AppConstant {
  static final String imagePath = "images/";

  static final GlobalKey mainScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "MainScreenKey",
  );
  static final GlobalKey<SideMenuState> allHabitScreenKey =
      GlobalKey<SideMenuState>(debugLabel: "AllHabitScreenKey");
  static final GlobalKey<SideMenuState> challengeScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "ChallengeScreenKey",
  );
  static final GlobalKey<SideMenuState> stepTrackingScreenKey = GlobalKey<SideMenuState>(
    debugLabel: "StepTrackingScreenKey",
  );

  static final List<GetPage> listPage = [
    GetPage(name: '/splash_screen', page: () => IntroScreen()), // sửa thành splash screen
    GetPage(name: '/manage_screen', page: () => ManageScreen()),
    //
    GetPage(name: '/main', page: () => MainScreen()), // nên đổi tên thành home
    GetPage(name: '/all_habit', page: () => AllHabitsScreen()),
    GetPage(name: '/challenge', page: () => ChallengesScreen()),
    GetPage(name: '/step_tracking', page: () => StepTackingScreen()),
    //
    GetPage(name: '/statistic', page: () => HabitStatisticScreen()),
    GetPage(name: '/note', page: () => HabitNoteScreen()),
    GetPage(name: '/all_note', page: () => HabitAllNoteScreen()),
    //
    GetPage(name: '/create_habit', page: () => CreateHabitScreen()),
    GetPage(name: '/edit_habit', page: () => EditHabitScreen()),
    //
    GetPage(name: '/suggest_category', page: () => HabitCategoriesScreen()),
    GetPage(name: '/suggest_category_list', page: () => HabitCategoryListScreen()),
    //
    GetPage(name: '/notification', page: () => NotificationScreen()),
    GetPage(name: '/general', page: () => GeneralScreen()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/timer', page: () => Timer())
  ];
}

enum AllNoteLoadingState {
  isLoading,
  noDataAvailable,
  isLoaded,
}
