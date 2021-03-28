import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:select_form_field/select_form_field.dart';

import './view_variables/create_habit_screen_variables.dart';
import 'view_subfile/create_and_edit_habit/create_and_edit_habit_screen_app_bar.dart';
import 'view_variables/create_habit_screen_variables.dart';

class CreateHabitScreen extends StatelessWidget {
  Habit habit;
  SuggestedHabit suggestedHabit;
  CreateHabitScreenController createHabitScreenController;

  @override
  Widget build(BuildContext context) {
    habitScreenContext = context;
    suggestedHabit = Get.arguments;
    // có tham số thì gán
    createHabitScreenController =
        Get.put(CreateHabitScreenController());
    createHabitScreenController.initDataAndController(suggestedHabit);

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
        CreateAndEditHabitScreenAppBar(
          controller: createHabitScreenController,
          title: "New habit",
        ),
        _habitScreenBody(),
      ],
    );
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
                  color: Colors.white,
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
                  enabledBorder: _textFieldBorder(),
                  focusedBorder: _textFieldBorder(),
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
            _sectionText(
              content: "I want to set a goal",
              canChange: false,
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
                      onTap: () => createHabitScreenController
                          .onOnOrOffButtonClick(index),
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
                            enabledBorder: _textFieldBorder(),
                            focusedBorder: _textFieldBorder(),
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
                            onChanged: (val) => createHabitScreenController
                                .changeSelectedUnitType(RxString(val)),
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
                              enabledBorder: _textFieldBorder(),
                              focusedBorder: _textFieldBorder(),
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
            _sectionText(
              content: "I want to repeat this habit",
              canChange: false,
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
            _sectionText(canChange: true),

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
                                    onTap: () => createHabitScreenController
                                        .changeWeekdateChoice(index),
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
                                    onTap: () => createHabitScreenController
                                        .changeWeeklyListChoice(index),
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
                    onTap: () =>
                        createHabitScreenController.onRepatTypeChoiceClick(),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: createHabitScreenController
                              .getRepeatTypeChoiceColor(),
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

            /// [Dòng chữ I will do it in]
            _sectionText(
              content: "I will do it in",
              canChange: false,
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
                            onTap: () => createHabitScreenController
                                .changeNotiTime(index),
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
                    onTap: () => createHabitScreenController.changeNotiTime(3),
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
                      onChanged: (value) =>
                          createHabitScreenController.changeIsGetReminder(),
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

  /// [TextField border]
  OutlineInputBorder _textFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.transparent),
    );
  }

  /// [Section text]
  Widget _sectionText({String content, bool canChange}) {
    return Container(
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
          canChange == false
              ? Text(
                  content,
                  style: TextStyle(fontSize: 20.0),
                )
              : Obx(
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
        ],
      ),
    );
  }

  /// [Widget icon và color]
  Widget _iconAndColorOptionWidget(
      IconData icon, String text, Color color, int index) {
    return Row(
      children: [
        InkWell(
          onTap: () => createHabitScreenController
              .onChooseIconOrColorButtonClick(index, habitScreenContext),
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
      onTap: () =>
          createHabitScreenController.onDayMonthYearReapeatChoiceClick(index),
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
}
