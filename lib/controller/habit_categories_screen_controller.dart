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

  Future<Map<String, dynamic>> initCategoriesCardInfo() async {
    return await databaseHelper.getSuggestTopicMap().then((value) {
      if (value != null && value.length != 0) {
        suggestTopicList = [];
        habitCategoryCards = [];

        for (int i = 0; i < value.length; i++) {
          suggestTopicList.add(
            SuggestedTopic(
              topicId: value[i]['topic_id'],
              topicName: value[i]['topic_name'],
              description: value[i]['description'],
              image: value[i]['image'],
            ),
          );

          habitCategoryCards.add(
            HabitCateGoryCard(
              title: value[i]['topic_name'],
              subtitle: value[i]['description'],
              imagePath: value[i]['image'],
            ),
          );
        }
        isLoadingCompleted.value = !isLoadingCompleted.value;
      }
    }).catchError((err) => debugPrint(err.toString()));
  }
}
