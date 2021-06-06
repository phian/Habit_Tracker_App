import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/controller/main_screen_controller.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/routing/routes.dart';

// ignore: must_be_immutable
class SwipeHabitTile extends StatefulWidget {
  final Habit habit;
  Process? process;

  SwipeHabitTile({required this.habit, this.process});

  @override
  _SwipeHabitTileState createState() => _SwipeHabitTileState();
}

class _SwipeHabitTileState extends State<SwipeHabitTile> {
  var controller = Get.find<MainScreenController>();

  bool checkIfSkippedOrCompleted() {
    if (widget.process != null) {
      bool isSkipped = widget.process!.isSkip;
      bool isCompleted = widget.process!.result == widget.habit.amount;
      return isSkipped || isCompleted;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
        backgroundColor: AppColors.c0000,
      key: UniqueKey(),
      leadingActions: checkIfSkippedOrCompleted()
          ? []
          : [
              SwipeAction(
                content: swipeItem('Done', AppColors.cFF4C, true),
                color: AppColors.c0000,
                widthSpace: 86,
                onTap: (CompletionHandler handler) async {
                  handler(false);
                  createProcessIfNull();
                  widget.process?.result = widget.habit.amount!;
                  controller.updateProcess(widget.process!);
                  controller.getListProcess(controller.selectedDate.value);
                  setState(() {});
                  print('done');
                },
              ),
              if (widget.habit.isSetGoal)
                SwipeAction(
                  content: swipeItem('+1', AppColors.cFFFE, true),
                  color: AppColors.c0000,
                  widthSpace: 86,
                  onTap: (CompletionHandler handler) async {
                    handler(false);
                    createProcessIfNull();
                    widget.process!.result++;
                    controller.updateProcess(widget.process!);
                    controller.getListProcess(controller.selectedDate.value);
                    setState(() {});
                    print('+1');
                  },
                ),
            ],
      trailingActions: checkIfSkippedOrCompleted()
          ? [
              SwipeAction(
                content: swipeItem('Note', AppColors.cFF9C, false),
                color: AppColors.c0000,
                widthSpace: 86,
                onTap: (CompletionHandler handler) async {
                  handler(false);
                  _moveToHabitNoteScreen(widget.habit);
                },
              ),
              SwipeAction(
                content: swipeItem('Undo', AppColors.cFFFF98, false),
                color: AppColors.c0000,
                widthSpace: 86,
                onTap: (CompletionHandler handler) async {
                  handler(false);
                  createProcessIfNull();
                  widget.process!.isSkip = false;
                  widget.process!.result = 0;
                  controller.updateProcess(widget.process!);
                  controller.getListProcess(controller.selectedDate.value);
                  setState(() {});
                  print('undo');
                },
              ),
            ]
          : [
              SwipeAction(
                content: swipeItem('Skip', AppColors.cFFFE, false),
                color: AppColors.c0000,
                widthSpace: 86,
                onTap: (CompletionHandler handler) async {
                  handler(false);
                  createProcessIfNull();
                  widget.process!.isSkip = true;
                  controller.updateProcess(widget.process!);
                  controller.getListProcess(controller.selectedDate.value);
                  setState(() {});
                  print('skip');
                },
              ),
            ],
      child: HabitTile(habit: widget.habit, process: widget.process),
    );
  }

  Widget swipeItem(String title, Color color, bool inLeading) {
    return Row(
      children: [
        if (inLeading) SizedBox(width: 16),
        Container(
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          child: Center(
            child: Text(title),
          ),
        ),
        if (!inLeading) SizedBox(width: 16),
      ],
    );
  }

  void createProcessIfNull() {
    if (widget.process == null) {
      print("create process");
      var date = controller.selectedDate.value;
      widget.process = Process(
        habitId: widget.habit.habitId,
        date: AppConstants.dateFormatter.format(date),
      );
      controller.createNewProcess(habitId: widget.habit.habitId, date: date);
    }
  }

  void _moveToHabitNoteScreen(Habit habit) {
    Get.toNamed(
      Routes.NOTE,
      arguments: [
        habit.habitId,
        controller.selectedDate.value,
      ],
    );
  }
}

class HabitTile extends StatelessWidget {
  final Habit habit;
  final Process? process;

  HabitTile({required this.habit, this.process});

  @override
  Widget build(BuildContext context) {
    bool isSkipped = false;
    bool isCompleted = false;

    if (process != null) {
      isSkipped = process!.isSkip;
      isCompleted = process!.result == habit.amount;
    }

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.cFF2F,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // icon
            Padding(
              padding: EdgeInsets.all(20),
              child: Icon(
                IconData(habit.icon, fontFamily: 'MaterialIcons'),
                size: 50,
                color: isSkipped || isCompleted
                    ? AppColors.cFF9E
                    : Color(int.parse(habit.color, radix: 16)),
              ),
            ),
            // title
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.habitName,
                      style: TextStyle(
                        fontSize: 22,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationThickness: 1.7,
                      ),
                      maxLines: 2,
                    ),
                    if (isSkipped)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.chevron_right,
                              size: 18,
                              color: AppColors.cFFFE,
                            ),
                            Text(
                              'Skipped',
                              style: TextStyle(
                                color: AppColors.cFFFE,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (isCompleted)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              size: 18,
                              color: AppColors.cFF11,
                            ),
                            Text(
                              '11 day streak !!',
                              style: TextStyle(
                                color: AppColors.cFF11,
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
            if (habit.isSetGoal)
              Padding(
                // process
                padding: EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (process == null ? '0' : '${process!.result}') +
                          '/${habit.amount}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(
                          int.parse(habit.color, radix: 16),
                        ),
                      ),
                    ),
                    Text(
                      habit.unit ?? "",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
      onTap: () {
        _moveToHabitStatisticScreen(habit);
      },
    );
  }

  void _moveToHabitStatisticScreen(Habit habit) {
    Get.toNamed(
      Routes.STATISTIC,
      arguments: habit,
    );
  }
}
