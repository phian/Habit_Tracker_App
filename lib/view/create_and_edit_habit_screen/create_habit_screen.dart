import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/create_habit_screen_controller.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:select_form_field/select_form_field.dart';

import 'create_and_edit_habit_screen_app_bar.dart';
import 'create_habit_screen_variables.dart';

class CreateHabitScreen extends StatefulWidget {
  @override
  _CreateHabitScreenState createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  SuggestedHabit _suggestedHabit;
  CreateHabitScreenController _createHabitScreenController;
  TextEditingController _habitNameController, _goalAmountController;

  @override
  void initState() {
    super.initState();
    _intControllerAndData();
  }

  void _intControllerAndData() {
    _createHabitScreenController = Get.put(CreateHabitScreenController());

    if (Get.arguments != null) {
      _suggestedHabit = Get.arguments;
      _createHabitScreenController.initDataAndController(_suggestedHabit);
      _habitNameController = TextEditingController(text: _suggestedHabit.ten);
      _goalAmountController =
          TextEditingController(text: _suggestedHabit.soLan.toString());
    } else {
      _habitNameController = TextEditingController();
      _goalAmountController = TextEditingController();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _createHabitScreenController.onClose();
    _habitNameController.dispose();
    _goalAmountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      // resizeToAvoidBottomInset: false,
      body: _createHabitScreenBody(),
    );
  }

  Widget _createHabitScreenBody() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: screenScrollController,
      slivers: [
        CreateAndEditHabitScreenAppBar(
          controller: _createHabitScreenController,
          title: "New habit",
          habitNameController: _habitNameController,
          goalAmountController: _goalAmountController,
        ),
        _habitScreenBody(),
      ],
    );
  }

  Widget _habitScreenBody() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            // Tên habit
            Obx(
              () => TextField(
                controller: _habitNameController,
                cursorColor: _createHabitScreenController.fillColor.value,
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
                      _createHabitScreenController.habitIcon.value,
                      "icon",
                      _createHabitScreenController.fillColor.value,
                      0,
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: EdgeInsets.only(left: Get.width * 0.25),
                      child: _iconAndColorOptionWidget(
                        Icons.circle,
                        "color",
                        _createHabitScreenController.fillColor.value,
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
                      onTap: () => _onOnOrOffButtonClick(index),
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
                            color: _createHabitScreenController
                                        .selectedIndex.value !=
                                    index
                                ? Colors.white24
                                : _createHabitScreenController.fillColor.value,
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
                visible: _createHabitScreenController.selectedIndex.value == 0
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
                          controller: _goalAmountController,
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
                            initialValue: _createHabitScreenController
                                .selectedUnitType.value,
                            items: unitTypes,
                            hintText: _createHabitScreenController
                                .selectedUnitType.value,
                            style: TextStyle(fontSize: 20.0),
                            onChanged: (val) => _createHabitScreenController
                                .changeSelectedUnitType(val),
                            onSaved: (val) => print(val),
                            scrollPhysics: AlwaysScrollableScrollPhysics(
                              parent: BouncingScrollPhysics(),
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white24,
                              filled: true,
                              hintText: _createHabitScreenController
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
                        color: _createHabitScreenController
                                    .repeatTypeChoice.value ==
                                index
                            ? _createHabitScreenController.fillColor.value
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
                          visible: _createHabitScreenController
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
                                    onTap: () => _createHabitScreenController
                                        .changeWeekdateChoice(index),
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: _createHabitScreenController
                                                      .weekDateList[index] ==
                                                  true
                                              ? _createHabitScreenController
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
                          visible: _createHabitScreenController
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
                                    onTap: () => _createHabitScreenController
                                        .changeWeeklyListChoice(index),
                                    child: Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: _createHabitScreenController
                                                          .weeklyChoiceList[
                                                      index] ==
                                                  true
                                              ? _createHabitScreenController
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
                        _createHabitScreenController.onRepeatTypeChoiceClick(),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: _createHabitScreenController
                              .getRepeatTypeChoiceColor(),
                        ),
                        child: Obx(
                          () => Text(
                            _createHabitScreenController
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
                            onTap: () => _createHabitScreenController
                                .changeNotiTime(index),
                            borderRadius: BorderRadius.circular(10.0),
                            child: Obx(
                              () => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _createHabitScreenController
                                              .notiTimeChoice[index] ==
                                          true
                                      ? _createHabitScreenController
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
                    onTap: () => _createHabitScreenController.changeNotiTime(3),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Obx(
                      () => Container(
                        alignment: Alignment.center,
                        width: Get.width,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color:
                              _createHabitScreenController.notiTimeChoice[3] ==
                                      true
                                  ? _createHabitScreenController.fillColor.value
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
                      activeColor: _createHabitScreenController.fillColor.value,
                      value: _createHabitScreenController.isGetReminder.value,
                      onChanged: (value) =>
                          _createHabitScreenController.changeIsGetReminder(),
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
                      color: _createHabitScreenController.fillColor.value
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
                    _createHabitScreenController.repeatTypeChoice.value == 0
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
          onTap: () => _onChooseIconOrColorButtonClick(index),
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
          _createHabitScreenController.onDayMonthYearRepeatChoiceClick(index),
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

  /// Icon and Color
  void _onChooseIconOrColorButtonClick(int index) {
    if (index == 1) {
      _showColorChoiceDialog();
    } else {
      _pickIconForHabit();
    }
  }

  /// [Hàm để show dialog cho người dùng chọn màu]
  void _showColorChoiceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
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
                            _createHabitScreenController
                                .changeFillColor(choiceColors[index]);
                          },
                          child: Obx(
                            () => Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: _createHabitScreenController
                                            .fillColor.value ==
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
                            _createHabitScreenController
                                .changeFillColor(choiceColors[index + 3]);
                          },
                          child: Obx(
                            () => Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: _createHabitScreenController
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
        );
      },
    );
  }

  /// [Hàm hiển thị dialog cho người dụng chọn icon]
  Future<void> _pickIconForHabit() async {
    IconData icon = await FlutterIconPicker.showIconPicker(
      context,
      iconPackMode: IconPack.material,
      iconSize: 30.0,
      backgroundColor: Colors.black,
      closeChild: null,
      searchHintText: "Search icon...",
      searchIcon: Icon(
        Icons.search,
        color: _createHabitScreenController.fillColor.value,
      ),
      iconColor: _createHabitScreenController.fillColor.value,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.5,
        minWidth: Get.width,
      ),
    );

    _createHabitScreenController.changeHabitIcon(icon);

    if (icon != null) debugPrint('Icon code point: ${icon.codePoint}');
  }

  void _onOnOrOffButtonClick(int index) {
    _createHabitScreenController.changeSelectedIndex(RxInt(index));

    /// [Nếu người dùng off goal thì sẽ reset lại text trong TextField]
    if (_createHabitScreenController.selectedIndex.value == 1) {
      _goalAmountController.text = '';
    }
  }
}
