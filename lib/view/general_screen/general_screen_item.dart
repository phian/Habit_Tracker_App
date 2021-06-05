import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';
import 'package:habit_tracker/routing/routes.dart';
import 'package:habit_tracker/view/general_screen/general_screen_variables.dart';
import 'package:habit_tracker/view/general_screen/widgets/start_week_selection_item.dart';
import 'package:habit_tracker/widgets/custom_confirm_dialog.dart';

class GeneralScreenItem extends StatefulWidget {
  final GeneralScreenController generalScreenController;
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool isSwitch;
  final GeneralItemType type;

  GeneralScreenItem({
    required this.generalScreenController,
    required this.icon,
    required this.iconColor,
    required this.isSwitch,
    required this.title,
    required this.type,
  });

  @override
  _GeneralScreenItemState createState() => _GeneralScreenItemState();
}

class _GeneralScreenItemState extends State<GeneralScreenItem> {
  late GeneralScreenVariables _variables;

  @override
  void initState() {
    super.initState();
    _variables = GeneralScreenVariables(
      controller: widget.generalScreenController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cFF2F,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        onTap: () {
          _handleItemClicked(widget.type);
        },
        leading: Icon(
          widget.icon,
          color: widget.iconColor,
          size: 30.0,
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 25.0),
        ),
        trailing: widget.isSwitch
            ? Obx(
                () => Switch(
                  value: widget.type == GeneralItemType.iconBadge
                      ? widget.generalScreenController.isOnIconBadge.value
                      : widget.type == GeneralItemType.vacationMode
                          ? widget.generalScreenController.isVacationMode.value
                          : widget.type == GeneralItemType.sounds
                              ? widget.generalScreenController.isOnSound.value
                              : widget
                                  .generalScreenController.isPasscodeLock.value,
                  onChanged: (value) => widget.generalScreenController
                      .changeSwitchData(widget.type),
                ),
              )
            : Icon(Icons.keyboard_arrow_right_outlined),
      ),
    );
  }

  void _handleItemClicked(GeneralItemType type) {
    switch (type) {
      case GeneralItemType.timeOfDay:
        Get.toNamed(Routes.TIME_OF_DAY);
        break;
      case GeneralItemType.startWeekOn:
        _showChoiceDialog(type, _variables.startWeekChoices);
        break;
      case GeneralItemType.iconBadge:
        widget.generalScreenController.changeSwitchData(type);
        break;
      case GeneralItemType.vacationMode:
        widget.generalScreenController.changeSwitchData(type);
        break;
      case GeneralItemType.unitsOfMeasure:
        _showChoiceDialog(type, _variables.unitOfMeasureChoices);
        break;
      case GeneralItemType.sounds:
        widget.generalScreenController.changeSwitchData(type);
        break;
      case GeneralItemType.notificationTone:
        _showChoiceDialog(type, _variables.notificationToneChoices);
        break;
      case GeneralItemType.passCodeLock:
        widget.generalScreenController.changeSwitchData(type);
        break;
      case GeneralItemType.cleanStateProtocol:
        _showCleanHabitDialog();
        break;
      case GeneralItemType.exportData:
        break;
      default:
        break;
    }
  }

  void _showChoiceDialog(GeneralItemType type, List<String> data) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.c0000,
            child: Obx(
              () => DirectSelect(
                itemExtent: 50.0,
                selectedIndex: () {
                  switch (type) {
                    case GeneralItemType.startWeekOn:
                      return widget
                          .generalScreenController.startWeekCurrentIndex.value;
                    case GeneralItemType.unitsOfMeasure:
                      return widget.generalScreenController
                          .unitsOfMeasureCurrentIndex.value;
                    case GeneralItemType.notificationTone:
                      return widget.generalScreenController
                          .notificationToneCurrentIndex.value;
                    default:
                      return widget.generalScreenController
                          .notificationToneCurrentIndex.value;
                  }
                }(),
                child: SelectionStartItem(
                  isForList: false,
                  title: widget.generalScreenController.getCurrentValue(type),
                ),
                onSelectedItemChanged: (index) {
                  if (index != null) {
                    widget.generalScreenController
                        .updateCurrentIndex(index, type);

                    widget.generalScreenController
                        .updateCurrentChoseValue(data[index], type);
                  }
                },
                items: data
                    .map(
                      (val) => SelectionStartItem(
                        title: val,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        });
  }

  void _showCleanHabitDialog() async {
    showDialog(
      context: context,
      builder: (_) {
        return CustomConfirmDialog(
          title: "Delete all habits?",
          positiveButtonText: 'Yes',
          onPositiveButtonTap: () {
            widget.generalScreenController.deleteAllHabit();
            Navigator.pop(context);
          },
          onNegativeButtonTap: () {
            Navigator.pop(context);
          },
          negativeButtonText: 'Cancel',
        );
      },
    );
  }
}
