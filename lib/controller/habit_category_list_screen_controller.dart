import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/service/database/database_helper.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:habit_tracker/view/habit_category_list_screen/suggest_habit_card.dart';

class HabitCategoryListScreenController extends GetxController {
  List<SuggestedHabit> suggestedHabitList;
  List<Widget> suggestHabitCards;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<Map<String, dynamic>> getSuggestHabitFromDb(int topicId) async {
    return await databaseHelper.getSussgestHabitMap(topicId).then((value) {
      if (value != null && value.length != 0) {
        suggestedHabitList = [];
        suggestHabitCards = [];

        for (int i = 0; i < value.length; i++) {
          suggestedHabitList.add(
            SuggestedHabit(
              maChuDe: value[i]['ma_chu_de'],
              ten: value[i]['ten'],
              moTa: value[i]['mo_ta'],
              icon: value[i]['icon'],
              mau: value[i]['mau'],
              batMucTieu: value[i]['bat_muc_tieu'] == 1 ? false : true,
              soLan: value[i]['so_lan'],
              donVi: value[i]['don_vi'],
              loaiLap: value[i]['loai_lap'],
              ngayTrongTuan: value[i]['ngay_trong_tuan'],
              soLanTrongTuan: value[i]['so_lan_trong_tuan'],
              buoi: value[i]['buoi'],
            ),
          );

          suggestHabitCards.add(
            SuggestHabitCard(
              iconCode: value[i]['icon'],
              title: value[i]['ten'],
              subTitle: value[i]['mo_ta'],
              color: int.parse(value[i]['mau']),
              index: i,
              habitCategoryListScreenController: this,
            ),
          );
        }
      }
    }).catchError((err) => debugPrint(err.toString()));
  }
}
