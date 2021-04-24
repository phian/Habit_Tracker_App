import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_routes.dart';
import 'package:habit_tracker/controller/habit_category_list_screen_controller.dart';


class SuggestHabitCard extends StatelessWidget {
  final int iconCode, color, index;
  final String title, subTitle;
  final HabitCategoryListScreenController habitCategoryListScreenController;

  SuggestHabitCard({
    this.iconCode,
    this.color,
    this.index,
    this.subTitle,
    this.title,
    this.habitCategoryListScreenController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: AppColors.c3DFF,
          ),
        ),
        onTap: () {
          Get.offNamed(
            Routes.CREATE_HABIT,
            arguments: this.habitCategoryListScreenController.suggestedHabitList[index],
            
          );
          
        },
        leading: Container(
          child: Icon(
            IconData(iconCode, fontFamily: 'MaterialIcons'),
            size: 40.0,
            color: Color(color),
          ),
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 10.0),
              Text(subTitle),
            ],
          ),
        ),
        trailing: Container(
          child: IconButton(
            icon: Icon(
              Icons.info_sharp,
              size: 30.0,
              color: AppColors.cFFF8,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
