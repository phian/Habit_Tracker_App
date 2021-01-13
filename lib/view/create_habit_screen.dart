import 'package:animate_icons/animate_icons.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/view/habit_categories_screen.dart';
import 'package:select_form_field/select_form_field.dart';
import './view_variables/create_habit_screen_variables.dart';
import 'manage_screen.dart';
import 'view_variables/create_habit_screen_variables.dart';

class CreateHabitScreen extends StatelessWidget {
  static Habit habit;

  @override
  Widget build(BuildContext context) {
    createHabitScreenContext = context;

    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      // resizeToAvoidBottomInset: false,
      body: _createHabitScreenBody(),
    );
  }

  // Widget chứa body của màn hình
  Widget _createHabitScreenBody() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: screenScrollController,
      slivers: [
        _habitScreenAppBar(),
        _habitScreenBody(),
      ],
    );
  }

  // AppBar
  Widget _habitScreenAppBar() {
    return SliverAppBar(
      expandedHeight: Get.size.height * 0.25,
      collapsedHeight: Get.size.height * 0.075,
      backgroundColor: Color(0xFF2F313E),
      pinned: true,
      flexibleSpace: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Image.asset(
              "images/forest.png",
              fit: BoxFit.cover,
              width: Get.size.width,
              height: Get.size.height * 0.3,
            ),
          ),
        ],
      ),
      leading: InkWell(
        borderRadius: BorderRadius.circular(90.0),
        child: Container(
          width: 30.0,
          height: 30.0,
          child: AnimateIcons(
            startIcon: Icons.close,
            endIcon: Icons.arrow_back,
            size: 25.0,
            controller: aniController,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  createHabitScreenController.resetController();
                  Get.to(
                    HabitCategoriesScreen(),
                    duration: Duration(milliseconds: 500),
                    transition: Transition.fadeIn,
                  );
                },
              );

              return true;
            },
            onEndIconPress: () {
              return true;
            },
            duration: Duration(milliseconds: 200),
            color: Colors.white,
            clockwise: true,
          ),
        ),
        onTap: () {
          Get.to(
            HabitCategoriesScreen(),
            duration: Duration(milliseconds: 500),
            transition: Transition.fadeIn,
          );
        },
      ),
      actions: [
        Container(
          transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              15.0,
            ),
            onTap: () {
              _saveHabitData();
            },
            child: Container(
              alignment: Alignment.center,
              width: 70.0,
              child: Text(
                "SAVE",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
      title: Text(
        'New Habit',
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),
    );
  }

  /// [Hàm để lưu data vào databaee]
  void _saveHabitData() {
    if ((createHabitScreenController.goalAmountController.text == '' ||
            int.parse(createHabitScreenController.goalAmountController.text) ==
                0) &&
        createHabitScreenController.selectedIndex.value == 0) {
      CoolAlert.show(
        context: createHabitScreenContext,
        type: CoolAlertType.error,
        animType: CoolAlertAnimType.slideInUp,
        title: "Forgot to set a goal?",
        text: "Check your goal for this habit",
      );
    } else {
      createHabitScreenController.addHabit();
      Get.to(ManageScreen());
    }
  }

  //====================================================//

  // Body
  Widget _habitScreenBody() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            // Tên habit
            Obx(
              () => TextField(
                controller: createHabitScreenController.habitNameController,
                cursorColor: createHabitScreenController.fillColor.value,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white54,
                ),
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Name of the habit',
                  hintStyle: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white54,
                  ),
                  fillColor: Colors.white24,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),

            /// [Phần chọn icon và color]
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Row(
                children: [
                  Obx(
                    () => _iconAndColorOptionWidget(
                      createHabitScreenController.habitIcon.value,
                      "icon",
                      createHabitScreenController.fillColor.value,
                      0,
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.only(left: Get.width * 0.25),
                      child: _iconAndColorOptionWidget(
                        Icons.circle,
                        "color",
                        createHabitScreenController.fillColor.value,
                        1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// [Dòng chữ I want to set a goal]
            Container(
              padding: EdgeInsets.only(top: 40.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "I want to set a goal",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
            ),

            /// [2 nút option on và off]
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...List.generate(
                    2,
                    (index) => InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        createHabitScreenController
                            .changeSelectedIndex(RxInt(index));

                        /// [Nếu người dùng off goal thì sẽ reset lại text trong TextField]
                        if (createHabitScreenController.selectedIndex.value ==
                            1) {
                          createHabitScreenController
                              .goalAmountController.text = '';
                        }
                      },
                      child: Obx(
                        () => Container(
                          height: 60.0,
                          alignment: Alignment.center,
                          width: Get.width * 0.44,
                          child: Text(
                            index == 0 ? "on" : "off",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: createHabitScreenController
                                        .selectedIndex.value !=
                                    index
                                ? Colors.white24
                                : createHabitScreenController.fillColor.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// [Phần chọn giá trị theo đơn vị]
            Obx(
              () => Visibility(
                visible: createHabitScreenController.selectedIndex.value == 0
                    ? true
                    : false,
                child: Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Get.width * 0.44,
                        height: 60.0,
                        child: TextField(
                          controller:
                              createHabitScreenController.goalAmountController,
                          style: TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          maxLengthEnforced: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CustomRangeTextInputFormatter(),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '0',
                            hintStyle: TextStyle(fontSize: 20.0),
                            fillColor: Colors.white24,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),

                      /// [Phần chọn đơn vị]
                      Container(
                        width: Get.width * 0.44,
                        height: 60.0,
                        child: Obx(
                          () => SelectFormField(
                            initialValue: createHabitScreenController
                                .selectedUnitType.value,
                            items: unitTypes,
                            hintText: createHabitScreenController
                                .selectedUnitType.value,
                            style: TextStyle(fontSize: 20.0),
                            onChanged: (val) {
                              createHabitScreenController
                                  .changeSelectedUnitType(RxString(val));
                            },
                            onSaved: (val) => print(val),
                            scrollPhysics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white24,
                              filled: true,
                              hintText: createHabitScreenController
                                  .selectedUnitType.value,
                              hintStyle: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                                size: 35.0,
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// [Dòng chữ I want to repeat this habit]
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "I want to repeat this habit",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
            ),

            /// [3 option Daily, Monthly, Weekly]
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(
                    3,
                    (index) => Obx(
                      () => _repeatChoiceWidget(
                        index == 0
                            ? "daily"
                            : index == 1
                                ? "weekly"
                                : "monthly",
                        color: createHabitScreenController
                                    .repeatTypeChoice.value ==
                                index
                            ? createHabitScreenController.fillColor.value
                            : Colors.white24,
                        index: index,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// [Dòng chữ On these days,...]
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        createHabitScreenController.repeatTypeChoice.value == 0
                            ? 'on these days'
                            : 'as often as',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
            ),

            /// [Phần chọn phần lập lại ngày trong tuần, tuần]
            Container(
              height: Get.height * 0.18,
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Obx(
                        () => Visibility(
                          visible: createHabitScreenController
                                      .repeatTypeChoice.value ==
                                  0
                              ? true
                              : false,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(
                                  7,
                                  (index) => InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    onTap: () {
                                      createHabitScreenController
                                          .changeWeekdateChoice(index);
                                    },
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: createHabitScreenController
                                                      .weekDateList[index] ==
                                                  true
                                              ? createHabitScreenController
                                                  .fillColor.value
                                              : Colors.white24,
                                        ),
                                        alignment: Alignment.center,
                                        width: 50.0,
                                        height: 60.0,
                                        child: Text(
                                          weekDayChoices[index],
                                          style: TextStyle(
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: createHabitScreenController
                                      .repeatTypeChoice.value ==
                                  1
                              ? true
                              : false,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(
                                  6,
                                  (index) => InkWell(
                                    borderRadius: BorderRadius.circular(10.0),
                                    onTap: () {
                                      createHabitScreenController
                                          .changeWeeklyListChoice(index);
                                    },
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: createHabitScreenController
                                                          .weeklyChoiceList[
                                                      index] ==
                                                  true
                                              ? createHabitScreenController
                                                  .fillColor.value
                                              : Colors.white24,
                                        ),
                                        alignment: Alignment.center,
                                        width: 50.0,
                                        height: 60.0,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: TextStyle(
                                            fontSize: 22.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      if (createHabitScreenController.repeatTypeChoice.value ==
                          0) {
                        createHabitScreenController.changeWeekdateChoice(7);
                      } else {
                        createHabitScreenController.changeWeeklyListChoice(6);
                      }
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: () {
                            if (createHabitScreenController
                                    .repeatTypeChoice.value ==
                                0) {
                              if (createHabitScreenController.weekDateList[7]) {
                                return createHabitScreenController
                                    .fillColor.value;
                              } else
                                return Colors.white24;
                            } else {
                              if (createHabitScreenController
                                  .weeklyChoiceList[6]) {
                                return createHabitScreenController
                                    .fillColor.value;
                              } else
                                return Colors.white24;
                            }
                          }(),
                        ),
                        child: Obx(
                          () => Text(
                            createHabitScreenController
                                        .repeatTypeChoice.value ==
                                    0
                                ? 'everyday'
                                : 'once every two weeks',
                            style: TextStyle(
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// [Dòng chữ I will do it in the]
            Container(
              padding: EdgeInsets.only(top: 30.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      "I will do it in the",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
            ),

            /// [Phần chọn buổi nhắc nhở]
            Container(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(
                          3,
                          (index) => InkWell(
                            onTap: () {
                              createHabitScreenController.changeNotiTime(index);
                            },
                            borderRadius: BorderRadius.circular(10.0),
                            child: Obx(
                              () => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: createHabitScreenController
                                              .notiTimeChoice[index] ==
                                          true
                                      ? createHabitScreenController
                                          .fillColor.value
                                      : Colors.white24,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                width: Get.width * 0.285,
                                height: 60.0,
                                child: Text(
                                  index == 0
                                      ? "morning"
                                      : index == 1
                                          ? "afternoon"
                                          : "evening",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  InkWell(
                    onTap: () {
                      createHabitScreenController.changeNotiTime(3);
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              createHabitScreenController.notiTimeChoice[3] ==
                                      true
                                  ? createHabitScreenController.fillColor.value
                                  : Colors.white24,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "Anytime",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// [Phần đặt thời gian nhắc nhở riêng cho thói quen]
            SizedBox(height: 30.0),
            Divider(
              thickness: 0.5,
              color: Colors.black,
            ),
            SizedBox(height: 5.0),
            Container(
              width: Get.width,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Get reminders",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Obx(
                    () => Switch(
                      activeColor: createHabitScreenController.fillColor.value,
                      value: createHabitScreenController.isGetReminder.value,
                      onChanged: (value) {
                        createHabitScreenController.changeIsGetReminder();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onTap: () {},
                leading: Obx(
                  () => Container(
                    child: Icon(Icons.add),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: createHabitScreenController.fillColor.value
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                  ),
                ),
                title: Text("Add reminder time"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [Hàm hiển thị dialog cho người dụng chọn icon]
  Future<void> _pickIconForHabit() async {
    IconData icon = await FlutterIconPicker.showIconPicker(
      createHabitScreenContext,
      iconPackMode: IconPack.material,
      iconSize: 30.0,
      backgroundColor: Colors.black,
      closeChild: null,
      searchHintText: "Search icon...",
      searchIcon: Icon(
        Icons.search,
        color: createHabitScreenController.fillColor.value,
      ),
      iconColor: createHabitScreenController.fillColor.value,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.5,
        minWidth: Get.width,
      ),
    );

    createHabitScreenController.changeHabitIcon(icon);

    ///debugPrint('Picked Icon:  $icon');
    debugPrint('Icon code point: ${icon.codePoint}');
  }

  /// [Widget icon và color]
  Widget _iconAndColorOptionWidget(
      IconData icon, String text, Color color, int index) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (index == 1) {
              _showColorChoiceDialog();
            } else {
              _pickIconForHabit();
            }
          },
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white24,
            ),
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 35.0,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
      ],
    );
  }

  /// [Widget cho phần chọn daily, weekly, monthy]
  Widget _repeatChoiceWidget(String choiceType, {Color color, int index}) {
    return InkWell(
      onTap: () {
        if (index != 2)
          createHabitScreenController.changeRepeatTypeIndex(RxInt(index));

        if (index == 1) {
          createHabitScreenController.resetWeekDateChoice();
        } else if (index == 0) {
          createHabitScreenController.resetWeeklyListChoice();
        }
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        alignment: Alignment.center,
        width: Get.width * 0.28,
        height: 60.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color != null ? color : Colors.white24,
        ),
        child: Text(
          choiceType,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }

  /// [Hàm để show dialog cho người dùng chọn màu]
  void _showColorChoiceDialog() {
    showDialog(
      context: createHabitScreenContext,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: Get.width * 0.8,
          height: Get.height * 0.35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black87,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "The color should be",
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  color: Colors.white,
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      3,
                      (index) => InkWell(
                        onTap: () {
                          Get.back();
                          createHabitScreenController
                              .changeFillColor(choiceColors[index]);
                        },
                        child: Obx(
                          () => Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color:
                                  createHabitScreenController.fillColor.value ==
                                          choiceColors[index]
                                      ? Colors.white24
                                      : Colors.transparent,
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 35.0,
                              color: choiceColors[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      3,
                      (index) => InkWell(
                        onTap: () {
                          Get.back();
                          createHabitScreenController
                              .changeFillColor(choiceColors[index + 3]);
                        },
                        child: Obx(
                          () => Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: createHabitScreenController
                                            .fillColor.value ==
                                        choiceColors[index + 3]
                                    ? Colors.white24
                                    : Colors.transparent),
                            child: Icon(
                              Icons.circle,
                              size: 35.0,
                              color: choiceColors[index + 3],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
