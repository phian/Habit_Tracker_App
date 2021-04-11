import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/model/suggest_topic.dart';
import 'package:habit_tracker/view/habit_categories_screen/habit_category_card.dart';

class HabitCategoriesScreenController extends GetxController {
  List<Widget> habitCategoryCards;
  List<SuggestedTopic> suggestTopicList;

  Future<Map<String, dynamic>> initCategoriesCardInfo({
    DatabaseHelper databaseHelper,
  }) async {
    return await databaseHelper.getSuggestTopicMap().then((value) {
      if (value != null && value.length != 0) {
        suggestTopicList = [];
        habitCategoryCards = [];

        for (int i = 0; i < value.length; i++) {
          suggestTopicList.add(
            SuggestedTopic(
              maChuDe: value[i]['ma_chu_de'],
              tenChuDeGoiY: value[i]['ten_chu_de_goi_y'],
              moTa: value[i]['mo_ta'],
              hinhChuDe: value[i]['hinh_chu_de'],
            ),
          );

          habitCategoryCards.add(
            HabitCateGoryCard(
              title: value[i]['ten_chu_de_goi_y'],
              subtitle: value[i]['mo_ta'],
              imagePath: value[i]['hinh_chu_de'],
            ),
          );
        }
      }
    }).catchError((err) => debugPrint(err.toString()));
  }
}
