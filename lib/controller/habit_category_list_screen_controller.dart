import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/view/habit_category_list_screen/suggest_habit_card.dart';

class HabitCategoryListScreenController extends GetxController {
  List<SuggestedHabit> suggestedHabitList;
  List<Widget> suggestHabitCards;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  RxBool isLoaded = false.obs;

  Future<Map<String, dynamic>> getSuggestHabitFromDb(int topicId) async {
    return await databaseHelper.getSussgestHabitMap(topicId).then((value) {
      if (value != null && value.length != 0) {
        suggestedHabitList = [];
        suggestHabitCards = [];

        for (int i = 0; i < value.length; i++) {
          suggestedHabitList.add(
            SuggestedHabit(
              topicId: value[i]['topic_id'],
              habitName: value[i]['habit_name'],
              description: value[i]['description'],
              icon: value[i]['icon'],
              color: value[i]['color'],
              isSetGoal: value[i]['is_set_goal'] == 1 ? true : false,
              amount: value[i]['amount'],
              unit: value[i]['unit'],
              repeatMode: value[i]['repeat_mode'],
              dayOfWeek: value[i]['day_of_week'],
              timesPerWeek: value[i]['times_per_week'],
              timeOfDay: value[i]['time_of_day'],
            ),
          );

          suggestHabitCards.add(
            SuggestHabitCard(
              iconCode: value[i]['icon'],
              title: value[i]['habit_name'],
              subTitle: value[i]['description'],
              color: int.parse(value[i]['color']),
              index: i,
              habitCategoryListScreenController: this,
            ),
          );
        }
        isLoaded.value = !isLoaded.value;
      }
    }).catchError((err) => debugPrint(err.toString()));
  }
}
