import 'package:get/get_navigation/src/routes/get_route.dart';

import '../main.dart';
import '../view/all_habits_screen.dart';
import '../view/challenges_screen.dart';
import '../view/create_and_edit_habit_screen/create_habit_screen.dart';
import '../view/create_and_edit_habit_screen/edit_habit_screen.dart';
import '../view/general_screen/genaral_screeen.dart';
import '../view/habit_all_note_screen/habit_all_note_screen.dart';
import '../view/habit_categories_screen/habit_categories_screen.dart';
import '../view/habit_category_list_screen/habit_category_list_screen.dart';
import '../view/habit_note_screen.dart';
import '../view/habit_statistic_screen.dart';
import '../view/login_screen.dart';
import '../view/main_screen.dart';
import '../view/manage_screen.dart';
import '../view/notification_screen.dart';
import '../view/step_tracking_screen.dart';

class Routes {
  static const SPLASH_SCREEN = '/splash_screen';
  static const MANAGE_SCRREN = '/manage_screen';
  static const MAIN_SCRREEN = '/main_screen';
  static const ALL_HABIT = '/all_habit';
  static const CHALLENGE = '/challenge';
  static const STEP_TRACKING = '/step_tracking';
  static const STATISTIC = '/statistic';
  static const NOTE = '/note';
  static const ALL_NOTE = '/all_note';
  static const CREATE_HABIT = '/create_habit';
  static const EDIT_HABIT = '/edit_habit';
  static const SUGGEST_CATEGORY = '/suggest_category';
  static const SUGGEST_CATEGORY_LIST = '/suggest_category_list';
  static const NOTIFICATION = '/notification';
  static const GENERAL = '/general';
  static const LOGIN = '/login';
}

class Pages {
  static final List<GetPage> pages = [
    GetPage(name: Routes.SPLASH_SCREEN, page: () => IntroScreen()), // sửa thành splash screen
    GetPage(name: Routes.MANAGE_SCRREN, page: () => ManageScreen()),
    //
    GetPage(name: Routes.MAIN_SCRREEN, page: () => MainScreen()), 
    GetPage(name: Routes.ALL_HABIT, page: () => AllHabitsScreen()),
    GetPage(name: Routes.CHALLENGE, page: () => ChallengesScreen()),
    GetPage(name: Routes.STEP_TRACKING, page: () => StepTackingScreen()),
    //
    GetPage(name: Routes.STATISTIC, page: () => HabitStatisticScreen()),
    GetPage(name: Routes.NOTE, page: () => HabitNoteScreen()),
    GetPage(name: Routes.ALL_NOTE, page: () => HabitAllNoteScreen()),
    //
    GetPage(name: Routes.CREATE_HABIT, page: () => CreateHabitScreen()),
    GetPage(name: Routes.EDIT_HABIT, page: () => EditHabitScreen()),
    //
    GetPage(name: Routes.SUGGEST_CATEGORY, page: () => HabitCategoriesScreen()),
    GetPage(name: Routes.SUGGEST_CATEGORY_LIST, page: () => HabitCategoryListScreen()),
    //
    GetPage(name: Routes.NOTIFICATION, page: () => NotificationScreen()),
    GetPage(name: Routes.GENERAL, page: () => GeneralScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
  ];
}

