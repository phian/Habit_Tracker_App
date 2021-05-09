import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_images.dart';

class NoNoteDataDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImages.icNote,
            width: context.width / 3,
            fit: BoxFit.cover,
            color: AppColors.cFFFF,
          ).marginOnly(bottom: 32.0),
          Text(
            "This habit don't have any note",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
