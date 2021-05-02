import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/suggest_topic.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/view/habit_categories_screen/habit_category_card.dart';

class HabitCategoriesScreenController extends GetxController {
  List<Widget> habitCategoryCards;
  List<SuggestedTopic> suggestTopicList;
  RxBool isLoadingCompleted = false.obs;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> initCategoriesCardInfo() async {
    suggestTopicList = await databaseHelper.getAllSuggestTopic();
    habitCategoryCards = [];
    for (int i = 0; i < suggestTopicList.length; i++) {
      habitCategoryCards.add(
        HabitCateGoryCard(
          title: suggestTopicList[i].topicName,
          subtitle: suggestTopicList[i].description,
          imagePath: suggestTopicList[i].image,
        ),
      );
    }
    isLoadingCompleted.value = !isLoadingCompleted.value;
  }
}
