import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/habit_all_note_screen_controller.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/view/habit_note_screen.dart';

class HabitAllNoteScreen extends StatelessWidget {
  HabitAllNoteScreenController _allNoteScreenController =
      Get.put(HabitAllNoteScreenController());

  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null)
      _allNoteScreenController.updateHabitId(Get.arguments);

    _readDateData();
    _readAllNoteData();

    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitAllNoteScreenAppBar(),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          physics: AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: [
            ...List.generate(_allNoteScreenController.dateList.length, (index) {
              return Container(
                child: Column(
                  children: [
                    _allNoteScreenController.dateListWidget[index],
                    SizedBox(height: 20.0),
                    _allNoteScreenController.noteContentBoxes[index],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// [Read date data]
  _readDateData() async {
    await _databaseHelper.readDataDataFromNoteTable().then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (_allNoteScreenController
                  .checkIfDateDataExist(value[i]['ngay'].toString()) ==
              false) {
            _allNoteScreenController.dateList.add(value[i]['ngay'].toString());
            _allNoteScreenController.dateListWidget.add(
                _dateDivider(value[i]['ngay'].toString().replaceAll(' ', '/')));
          }
        }
      }
    });
  }

  /// [Read all note content]
  _readAllNoteData() async {
    await _databaseHelper.readAllNoteData().then((value) {
      if (value.length != 0) {
        for (int i = 0; i < value.length; i++) {
          if (_allNoteScreenController
                  .checkIfContentExist(value[i]['noi_dung'].toString()) ==
              false) {
            _allNoteScreenController.noteContent
                .add(value[i]['noi_dung'].toString());
            _allNoteScreenController.noteContentBoxes
                .add(_noteContentCard(value[i]['noi_dung'].toString()));
          }
        }
      }
      print("Có vô đây");
    });
  }

  /// [App Bar]
  Widget _habitAllNoteScreenAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30.0,
        ),
      ),
      title: Text(
        "My notes",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// [Dòng phân chia ngày]
  Widget _dateDivider(String date) {
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
                color: Colors.white24,
              ),
            ),
          ),
          Text(
            date,
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [Card chứa nội dung]
  Widget _noteContentCard(String content) {
    return GestureDetector(
      onTap: () {
        Get.to(
          HabitNoteScreen(),
          arguments: _allNoteScreenController.habitId.value,
          transition: Transition.fadeIn,
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        alignment: Alignment.centerLeft,
        height: Get.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFF2F313E),
        ),
        child: Text(
          content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
