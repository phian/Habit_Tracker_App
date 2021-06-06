import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/time_of_day_controller.dart';
import 'package:habit_tracker/widgets/alert_dialog.dart';

class TimeOfDayScreen extends StatefulWidget {
  @override
  _TimeOfDayScreenState createState() => _TimeOfDayScreenState();
}

class _TimeOfDayScreenState extends State<TimeOfDayScreen> {
  TimeOfDayController _controller = Get.put(TimeOfDayController());

  @override
  void initState() {
    super.initState();
    _controller.initStartTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF1E,
      appBar: _timeOfDayScreenAppBar(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          _buildTileWidget(
            icon: Icons.wb_sunny,
            title: "MORNING",
            icoColor: AppColors.cFFFE,
            time: _controller.morningStartTime,
            type: TimeType.morning,
          ),
          _buildTileWidget(
            icon: Icons.cloud,
            title: "AFTERNOON",
            icoColor: AppColors.cFF1C,
            time: _controller.afternoonStartTime,
            type: TimeType.afternoon,
          ),
          _buildTileWidget(
            icon: Icons.nightlight_round,
            title: "EVENING",
            icoColor: AppColors.cFFFA,
            time: _controller.eveningStartTime,
            type: TimeType.evening,
          ),
        ],
      ).paddingOnly(top: 16.0),
    );
  }

  /// [App Bar]
  PreferredSizeWidget _timeOfDayScreenAppBar() {
    return AppBar(
      title: Text(
        "Time of day",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.c1F00,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  Widget _buildTileWidget({
    required IconData icon,
    required String title,
    required Color icoColor,
    required RxString time,
    required TimeType type,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w300,
          ),
        ).marginOnly(bottom: 12.0, left: 16.0),
        Material(
          color: AppColors.c1FFF,
          child: ListTile(
            onTap: () {
              _handleTimePickerData(type);
            },
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            leading: Icon(icon, color: icoColor, size: 35.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Starts at",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Obx(
                  () => Text(
                    time.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_right),
          ),
        ),
      ],
    ).marginOnly(top: 16.0);
  }

  void _handleTimePickerData(TimeType type) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value != null) {
        var temp = value.hour.toDouble() + value.minute.toDouble() / 60;
        switch (type) {
          case TimeType.morning:
            if (temp > 12.0) {
              showAlert(
                context: context,
                type: CoolAlertType.error,
                title: "Alert!",
                text: "Please select time between 00:00 and 11:59",
              );
              return;
            }
            break;
          case TimeType.afternoon:
            if (temp > 17.0) {
              showAlert(
                context: context,
                type: CoolAlertType.error,
                title: "Alert!",
                text: "Please select time between 12:00 and 16:59",
              );
              return;
            }
            break;
          case TimeType.evening:
            if (temp < 17.0) {
              showAlert(
                context: context,
                type: CoolAlertType.error,
                title: "Alert!",
                text: "Please select time between 17:00 and 23:59",
              );
              return;
            }
            break;
        }

        var result = "${value.hour.toString().padLeft(2, "0")}"
            ":${value.minute.toString().padLeft(2, "0")}";
        _controller.saveTimeData(type, result);
      }
    }).catchError((err) {
      print(err.toString());
    });
  }
}

enum TimeType {
  morning,
  afternoon,
  evening,
}
