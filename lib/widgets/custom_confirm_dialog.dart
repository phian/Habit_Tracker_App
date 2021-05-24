import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';

class CustomConfirmDialog extends StatelessWidget {
  final Color dialogBackgroundColor;
  final String title;
  final String content;
  final String positiveButtonText;
  final String negativeButtonText;
  final Color titleColor;
  final Color contentColor;
  final Color positiveTextColor;
  final Color negativeTextColor;
  final Function onPositiveButtonTap;
  final Function onNegativeButtonTap;

  CustomConfirmDialog({
    this.dialogBackgroundColor,
    @required this.title,
    this.content,
    this.titleColor,
    this.contentColor,
    this.positiveButtonText,
    this.positiveTextColor,
    @required this.negativeButtonText,
    this.negativeTextColor,
    this.onPositiveButtonTap,
    @required this.onNegativeButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: dialogBackgroundColor ?? AppColors.cFF2F,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //this right here
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor ?? AppColors.cFFFF,
                  fontSize: 22.0,
                ),
              ),
            ).marginOnly(bottom: 12.0),
            content != null
                ? Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: contentColor ?? AppColors.cFFFF,
                      fontSize: 22.0,
                    ),
                  ).marginOnly(bottom: 12.0)
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                onPositiveButtonTap != null
                    ? TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          onPositiveButtonTap.call();
                        },
                        child: Text(
                          positiveButtonText ?? "Yes",
                          style: TextStyle(
                            color: positiveTextColor ?? AppColors.cFF1C,
                            fontSize: 20.0,
                          ),
                        ),
                      ).marginOnly(right: 16.0)
                    : Container(),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    onNegativeButtonTap.call();
                  },
                  child: Text(
                    negativeButtonText ?? 'No',
                    style: TextStyle(
                      color: negativeTextColor ?? AppColors.cFF1C,
                      fontSize: 20.0,
                    ),
                  ),
                ).marginOnly(right: 12.0),
              ],
            )
          ],
        ),
      ),
    );
  }
}
