import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';
import 'package:habit_tracker/controller/habit_categories_screen_controller.dart';

import '../habit_category_list_screen/habit_category_list_screen.dart';
import 'create_your_own_card.dart';

class HabitCategoriesScreen extends StatefulWidget {
  HabitCategoriesScreen({Key key}) : super(key: key);

  @override
  _HabitCategoriesScreenState createState() => _HabitCategoriesScreenState();
}

class _HabitCategoriesScreenState extends State<HabitCategoriesScreen> {
  AnimateIconController _controller;
  HabitCategoriesScreenController _categoriesScreenController;

  @override
  void initState() {
    super.initState();
    _categoriesScreenController = Get.put(HabitCategoriesScreenController());
    _categoriesScreenController.initCategoriesCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitCategoriesAppBar(),
      body: _habitCategoriesBody(),
    );
  }

//====================================================================//

  // Appbar
  Widget _habitCategoriesAppBar() {
    return AppBar(
      leading: Container(
        transform: Matrix4.translationValues(-3.0, -3.2, 0.0),
        child: IconButton(
          icon: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu_rounded,
            size: 30.0,
            controller: _controller,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  Get.back();
                },
              );

              return true;
            },
            onEndIconPress: () {
              return true;
            },
            duration: Duration(milliseconds: 200),
            startIconColor: Colors.white,
            endIconColor: Colors.white,
            clockwise: true,
          ),
          onPressed: null,
        ),
      ),
      title: Container(
        transform: Matrix4.translationValues(
          -MediaQuery.of(context).size.width * 0.05,
          2.0,
          0.0,
        ),
        alignment: Alignment.center,
        child: Text(
          "Habit categories",
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  //====================================================================//

  // Body
  Widget _habitCategoriesBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: ListView(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 10.0,
          right: 10.0,
          bottom: 20.0,
        ),
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Text(
            "Create your own",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CreateYourOwnCard(
            icon: Icons.calendar_today_rounded,
            iconColor: Color(0xFF4949f4),
            title: "Regular Habit",
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Or choose in these categories",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Obx(() => _categoriesScreenController.isLoadingCompleted.value
              ? Column(
                  children: [
                    ...List.generate(
                      _categoriesScreenController.suggestTopicList.length,
                      (index) => Hero(
                        tag: _categoriesScreenController
                            .suggestTopicList[index].tenChuDeGoiY,
                        child: Container(
                          margin: index == 0
                              ? null
                              : EdgeInsets.only(
                                  top: 15.0,
                                ),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Color(0xFF2F313E),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0),
                              onTap: () => _onCategoryCardPressed(index),
                              child: _categoriesScreenController
                                  .habitCategoryCards[index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SpinKitFadingCube(color: AppColors.cFFFF)),
        ],
      ),
    );
  }

  void _onCategoryCardPressed(int index) {
    if (index != 17) {
      Get.to(
            () => HabitCategoryListScreen(
          tag: _categoriesScreenController.suggestTopicList[index].tenChuDeGoiY,
          topicId: _categoriesScreenController.suggestTopicList[index].maChuDe,
          imagePath:
              _categoriesScreenController.suggestTopicList[index].hinhChuDe,
        ),
      );
    }
  }
}
