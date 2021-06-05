import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DailyChartWidget extends StatefulWidget {
  final int totalSteps, goalSteps;

  DailyChartWidget({required this.totalSteps, required this.goalSteps});

  @override
  _DailyChartWidgetState createState() => _DailyChartWidgetState();
}

class _DailyChartWidgetState extends State<DailyChartWidget> {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animationDuration: 0,
      radius: context.width / 1.6,
      lineWidth: 15.0,
      animation: true,
      percent: widget.totalSteps == 0 && widget.goalSteps == 0
          ? 0.0
          : widget.totalSteps / widget.goalSteps,
      center: Text(
        widget.totalSteps != 0 && widget.goalSteps != 0
            ? "Progress: ${(widget.totalSteps / widget.goalSteps * 100).toString().substring(0, 2)}%"
            : "Progress: 0%",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: AppColors.cFF69,
      backgroundColor: AppColors.c3DFF,
    );
  }
}
