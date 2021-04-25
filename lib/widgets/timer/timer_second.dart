import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/widgets/timer/controller/timer_controller.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class TimerSecond extends StatefulWidget {
  @override
  _TimerSecondState createState() => _TimerSecondState();
}

class _TimerSecondState extends State<TimerSecond>
    with TickerProviderStateMixin {
  TimerController _controller = Get.put(TimerController());
  AnimationController _aniController;

  String get _timeValue {
    Duration duration = _aniController.value != 0
        ? _aniController.duration * _aniController.value
        : _aniController.duration;
    return "${duration.inHours.toString().padLeft(2, '0')}:"
        "${duration.inMinutes.toString().padLeft(2, '0')}:"
        "${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();
    _initAnimationController();
  }

  void _initAnimationController() {
    _aniController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

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
        "Let's challenge",
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
              AnimatedBuilder(
                animation: _aniController,
                builder: (_, __) {
                  return Text(
                    _timeValue,
                    style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ).marginOnly(bottom: 64.0);
                },
              ),
              Container(
                width: context.width / 1.5,
                height: context.width / 1.5,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: AppColors.cFFFF,
                  shape: BoxShape.circle,
                ),
                child: _buildWaveWidget(),
              ).marginOnly(bottom: 64.0),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => IgnorePointer(
                  ignoring: !_controller.canReset.value,
                  child: InkWell(
                    onTap: () {
                      _controller.onStop();
                      setState(() {
                        _aniController.reset();
                      });
                    },
                    borderRadius: BorderRadius.circular(90.0),
                    child: AnimatedBuilder(
                      animation: _aniController,
                      builder: (_, __) {
                        return Container(
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
                              child: Icon(Icons.refresh_sharp),
                            ),
                          ),
                        ).marginOnly(right: 128.0);
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (_controller.canStart.value) {
                      _controller.onBegin();

                      _aniController
                          .reverse(
                              from: _aniController.value == 0.0
                                  ? 1.0
                                  : _aniController.value)
                          .whenComplete(
                        () {
                          _controller.onStop();
                          _initAnimationController();
                        },
                      );
                    } else {
                      _controller.onPause();
                      _aniController.stop();
                    }
                  });
                },
                borderRadius: BorderRadius.circular(90.0),
                child: AnimatedBuilder(
                  animation: _aniController,
                  builder: (_, __) {
                    return Container(
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
                          child: Icon(_controller.canStart.value
                              ? Icons.play_arrow
                              : Icons.pause),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    ).paddingSymmetric(horizontal: 32.0, vertical: 50.0);
  }

  Widget _buildWaveWidget() {
    return ClipOval(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: AnimatedBuilder(
        animation: _aniController,
        builder: (_, __) {
          return WaveWidget(
            config: CustomConfig(
              gradients: [
                // [Colors.red, Color(0xEEF44336)],
                [Colors.red[800], Color(0x77E57373)],
                // [Colors.orange, Color(0x66FF9800)],
                [Colors.yellow, Color(0x55FFEB3B)]
              ],
              durations: [5000, 5500],
              heightPercentages: [
                _aniController.value == 0 ? 1.0 : _aniController.value,
                _aniController.value == 0 ? 1.0 : _aniController.value,
              ],
              // blur: MaskFilter.blur(BlurStyle.inner, 10.0),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            backgroundColor: AppColors.c0000,
            size: Size(context.width / 1.5, context.width / 1.5),
            waveAmplitude: 0,
            waveFrequency: 2.0,
            wavePhase: 20.0,
          );
        },
      ),
    );
  }

  Widget _buildTimerButton(RxBool value, IconData icon) {
    return Obx(
      () => AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: _controller.canStart.value ? 0.0 : 1.0,
        child: IgnorePointer(
          ignoring: _controller.canStart.value,
          child: InkWell(
            onTap: () {
              _controller.onBegin();
              setState(() {
                if (_aniController.isAnimating) {
                  _aniController.stop(canceled: true);
                } else {
                  _aniController.reverse(
                      from: _aniController.value == 0.0
                          ? 1.0
                          : _aniController.value);
                }
              });
            },
            borderRadius: BorderRadius.circular(90.0),
            child: AnimatedBuilder(
              animation: _aniController,
              builder: (_, __) {
                return Container(
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
