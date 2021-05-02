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

  Future<void> getSuggestHabitFromDb(int topicId) async {
    suggestedHabitList = await databaseHelper.getSussgestHabit(topicId);

    suggestHabitCards = [];

    for (int i = 0; i < suggestedHabitList.length; i++) {
      suggestHabitCards.add(
        SuggestHabitCard(
          iconCode: suggestedHabitList[i].icon,
          title: suggestedHabitList[i].habitName,
          subTitle: suggestedHabitList[i].description,
          color: int.parse(suggestedHabitList[i].color),
          index: i,
          habitCategoryListScreenController: this,
        ),
      );
    }
    isLoaded.value = !isLoaded.value;
  }
}
