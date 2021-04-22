import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/widgets/timer/controller/timer_controller.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  TimerController _controller = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: AppColors.cFF1E,
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.c0000,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        "Let's begin",
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "00:00:00",
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.w400,
                ),
              ).marginOnly(bottom: 64.0),
              Container(
                width: context.width / 2,
                height: context.width / 2,
                decoration: BoxDecoration(
                  color: AppColors.cFFFF,
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: WaveWidget(
                    config: CustomConfig(
                      gradients: [
                        [Colors.red, Color(0xEEF44336)],
                        [Colors.red[800], Color(0x77E57373)],
                        [Colors.orange, Color(0x66FF9800)],
                        [Colors.yellow, Color(0x55FFEB3B)]
                      ],
                      durations: [35000, 19440, 10800, 6000],
                      heightPercentages: [0.20, 0.23, 0.25, 0.30],
                      blur: MaskFilter.blur(BlurStyle.inner, 10.0),
                      gradientBegin: Alignment.bottomLeft,
                      gradientEnd: Alignment.topRight,
                    ),
                    backgroundColor: AppColors.c0000,
                    size: Size(context.width / 2, context.width / 2),
                    waveAmplitude: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _controller.isStopped.value ? 0.0 : 1.0,
                  child: IgnorePointer(
                    ignoring: _controller.isStopped.value,
                    child: InkWell(
                      onTap: () {
                        _controller.onStop();
                      },
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: AppColors.cFFF5,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cFFFF,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.cFFF5,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.stop),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _controller.isStarted.value ? 0.0 : 1.0,
                  child: IgnorePointer(
                    ignoring: _controller.isStarted.value,
                    child: InkWell(
                      onTap: () {
                        _controller.onBegin();
                      },
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: AppColors.cFFF5,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cFFFF,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.cFFF5,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.play_arrow),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _controller.isPaused.value ? 0.0 : 1.0,
                  child: IgnorePointer(
                    ignoring: _controller.isPaused.value,
                    child: InkWell(
                      onTap: () {
                        _controller.onPause();
                      },
                      borderRadius: BorderRadius.circular(90.0),
                      child: Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: AppColors.cFFF5,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cFFFF,
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.cFFF5,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.pause),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 32.0, vertical: 50.0);
  }
}
