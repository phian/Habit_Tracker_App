import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/suggest_topic.dart';
import 'package:habit_tracker/view/habit_category_list_screen.dart';

import 'create_habit_screen.dart';
import 'manage_screen.dart';

class HabitCategoriesScreen extends StatefulWidget {
  HabitCategoriesScreen({Key key}) : super(key: key);

  @override
  _HabitCategoriesScreenState createState() => _HabitCategoriesScreenState();
}

class _HabitCategoriesScreenState extends State<HabitCategoriesScreen> {
  AnimateIconController _controller;
  List<Widget> _habitCategoryCards;

  List<SuggestedTopic> _suggestTopicList;
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _suggestTopicList = [];
    _databaseHelper = DatabaseHelper.instance;

    _initCategoriesCardInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _habitCategoriesAppBar(),
      body: _habitCateGoriesBody(),
    );
  }

//====================================================================//

  // Appbar
  Widget _habitCategoriesAppBar() {
    return AppBar(
      leading: Container(
        transform: Matrix4.translationValues(-3.0, -4.0, 0.0),
        child: IconButton(
          icon: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu_rounded,
            size: 35.0,
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
            color: Colors.white,
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
  Widget _habitCateGoriesBody() {
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
          _createYourOwnCard(
              Icons.calendar_today_rounded, Color(0xFF4949f4), "Regular habit"),
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
          ...List.generate(
              _suggestTopicList.length,
              (index) => Hero(
                    tag: _suggestTopicList[index].tenChuDeGoiY,
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
                          onTap: () {
                            if (index != 17) {
                              Get.to(
                                HabitCategoryListScreen(
                                  tag: _suggestTopicList[index].tenChuDeGoiY,
                                  topicId: _suggestTopicList[index].maChuDe,
                                  imagePath: _suggestTopicList[index].hinhChuDe,
                                ),
                              );
                            }
                          },
                          child: _habitCategoryCards[index],
                        ),
                      ),
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _createYourOwnCard(IconData icon, Color iconColor, String title) {
    return Material(
      borderRadius: BorderRadius.circular(20.0),
      color: Color(0xFF2F313E),
      child: InkWell(
        highlightColor: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          Get.to(
            CreateHabitScreen(),
            duration: Duration(milliseconds: 500),
            transition: Transition.fadeIn,
          );
        },
        child: Container(
          padding: EdgeInsets.only(left: 30.0),
          height: 80.0,
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 35.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 2.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _habitCateGoryCard(String title, String subtitle, String imagePath) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 220.0,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0, top: 5.0),
                width: 200.0,
                child: Text(
                  subtitle,
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFF9A9DA4),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // Hàm get dữ liệu từ database
  Future<Null> _initCategoriesCardInfo() async {
    await _databaseHelper.getSuggestTopicMap().then((value) {
      _suggestTopicList = [];
      _habitCategoryCards = [];

      for (int i = 0; i < value.length; i++) {
        _suggestTopicList.add(SuggestedTopic(
          maChuDe: value[i]['ma_chu_de'],
          tenChuDeGoiY: value[i]['ten_chu_de_goi_y'],
          moTa: value[i]['mo_ta'],
          hinhChuDe: value[i]['hinh_chu_de'],
        ));

        _habitCategoryCards.add(_habitCateGoryCard(value[i]['ten_chu_de_goi_y'],
            value[i]['mo_ta'], value[i]['hinh_chu_de']));
      }

      setState(() {});
    });
  }
}
