import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/widgets/timer/controller/timer_controller.dart';
import 'package:habit_tracker/widgets/timer/widgets/timer_painter.dart';

class Timer extends StatefulWidget {
  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
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
      backgroundColor: AppColors.cFF1E,
      // appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ).marginOnly(top: 32.0, left: 8.0),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildAppBar(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: context.width / 1.35,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _aniController,
                    builder: (BuildContext context, Widget child) {
                      return Text(
                        _timeValue,
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cFFFF,
                        ),
                      ).marginOnly(top: 8.0);
                    },
                  ),
                  Container(
                    width: context.width / 1.35,
                    height: context.width / 1.35,
                    child: AnimatedBuilder(
                      animation: _aniController,
                      builder: (_, __) {
                        return CustomPaint(
                          painter: TimerPainter(
                            animation: _aniController,
                            backgroundColor: Colors.white,
                            color: AppColors.cFFFFD9,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ).marginOnly(bottom: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => IgnorePointer(
                    ignoring: !_controller.canReset.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cFF93,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        alignment: Alignment.center,
                        iconSize: 40.0,
                        icon: Icon(Icons.refresh_sharp),
                        onPressed: () {
                          _controller.onStop();
                          setState(() {
                            _aniController.reset();
                          });
                        },
                      ),
                    ).marginOnly(right: 128.0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cFF93,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    alignment: Alignment.center,
                    iconSize: 40.0,
                    icon: Obx(
                      () => Icon(
                        _controller.canStart.value
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                    ),
                    onPressed: () {
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
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 24.0),
          ],
        ).paddingOnly(bottom: context.width / 2),
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "${AppConstant.imagePath}timer_img.png",
            fit: BoxFit.contain,
            width: context.width / 1.75,
            height: context.width / 1.75,
          ).marginOnly(bottom: 24.0),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _cloudIcon(50.0).marginOnly(
            bottom: context.width / 2,
            left: context.width * 0.2,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _cloudIcon(30.0).marginOnly(
            bottom: context.width / 3,
            left: context.width * 0.1,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: _cloudIcon(60.0).marginOnly(
            bottom: context.width / 2.5,
            right: context.width * 0.1,
          ),
        ),
      ],
    );
  }

  Widget _cloudIcon(double size) {
    return Icon(
      Icons.cloud,
      size: size,
      color: AppColors.cFFEE,
    );
  }
}
