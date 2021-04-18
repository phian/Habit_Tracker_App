import 'package:flutter/material.dart';
import 'package:habit_tracker/constants/app_color.dart';

class HabitCateGoryCard extends StatelessWidget {
  final String title, subtitle, imagePath;
  HabitCateGoryCard({this.title, this.subtitle, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 220.0,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.cFFFF,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0, top: 5.0),
                width: 200.0,
                child: Text(
                  subtitle,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.cFF9A,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
