import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:habit_tracker/view/help_screen.dart';
import 'package:habit_tracker/view/time_of_day_screen.dart';
import 'package:habit_tracker/widgets/timer/timer.dart';

import '../main.dart';
import '../routing/routes.dart';
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
import '../view/step_tracking.dart';
import '../view/step_tracking_screen/step_tracking_screen.dart';

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
    GetPage(
        name: Routes.SUGGEST_CATEGORY_LIST,
        page: () => HabitCategoryListScreen()),
    //
    GetPage(name: Routes.NOTIFICATION, page: () => NotificationScreen()),
    GetPage(name: Routes.GENERAL, page: () => GeneralScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    //
    GetPage(name: Routes.TIMER, page: () => Timer()),
    //
    GetPage(name: Routes.STEP, page: () => StepTracking()),
    //
    GetPage(name: Routes.TIME_OF_DAY, page: () => TimeOfDayScreen()),
    //
    GetPage(name: Routes.HELP, page: () => HelpScreen()),
  ];
}

