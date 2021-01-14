import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/database/database_helper.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:habit_tracker/view/create_habit_screen.dart';

import 'habit_categories_screen.dart';

class HabitCategoryListScreen extends StatefulWidget {
  final String tag;
  final int topicId;
  final String imagePath;
  HabitCategoryListScreen({
    Key key,
    this.tag,
    this.topicId,
    this.imagePath,
  }) : super(key: key);

  @override
  _HabitCategoryListScreenState createState() =>
      _HabitCategoryListScreenState();
}

class _HabitCategoryListScreenState extends State<HabitCategoryListScreen> {
  DatabaseHelper _databaseHelper;
  List<SuggestedHabit> _suggestedHabitList;

  ScrollController _screenScrollController;
  AnimateIconController _aniController;

  List<Widget> _suggestHabitCards;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;

    _screenScrollController = ScrollController();
    _aniController = AnimateIconController();

    _getSuggestHabitFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: Scaffold(
        // appBar: ,
        body: _createHabitScreenBody(),
      ),
    );
  }

  // Widget chứa body của màn hình
  Widget _createHabitScreenBody() {
    return CustomScrollView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _screenScrollController,
      slivers: [
        _suggestHabitScreenAppBar(),
        _suggestHabitScreenBody(),
      ],
    );
  }

  Future<Null> _getSuggestHabitFromDb() async {
    await _databaseHelper.getSussgestHabitMap(widget.topicId).then((value) {
      _suggestedHabitList = [];
      _suggestHabitCards = [];

      for (int i = 0; i < value.length; i++) {
        _suggestedHabitList.add(
          SuggestedHabit(
            maChuDe: value[i]['ma_chu_de'],
            ten: value[i]['ten'],
            moTa: value[i]['mo_ta'],
            icon: value[i]['icon'],
            mau: value[i]['mau'],
            batMucTieu: value[i]['bat_muc_tieu'] == 1 ? false : true,
            soLan: value[i]['so_lan'],
            donVi: value[i]['don_vi'],
            loaiLap: value[i]['loai_lap'],
            ngayTrongTuan: value[i]['ngay_trong_tuan'],
            soLanTrongTuan: value[i]['so_lan_trong_tuan'],
            buoi: value[i]['buoi'],
          ),
        );

        _suggestHabitCards.add(
          _suggestHabitCard(
            value[i]['icon'],
            value[i]['ten'],
            value[i]['mo_ta'],
            int.parse(value[i]['mau']),
            i,
          ),
        );
      }

      setState(() {});
    });
  }

  // Appbar
  Widget _suggestHabitScreenAppBar() {
    return SliverAppBar(
      expandedHeight: Get.size.height * 0.2,
      collapsedHeight: Get.size.height * 0.075,
      backgroundColor: Color(0xFF2F313E),
      pinned: true,
      floating: true,
      flexibleSpace: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0, top: 80.0),
            width: Get.width * 0.55,
            child: Text(
              widget.tag,
              maxLines: 2,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.5, top: 30.0),
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.contain,
              width: Get.size.width * 0.6,
              height: Get.size.height * 0.22,
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
            controller: _aniController,
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
        ),
        onTap: () {},
      ),
      bottom: PreferredSize(
        preferredSize: Size(Get.width, Get.size.height * 0.15),
        child: AppBar(
          leading: Text(""),
          leadingWidth: 0.0,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
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

  // Body
  Widget _suggestHabitScreenBody() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.0, left: Get.width * 0.05),
              alignment: Alignment.topLeft,
              child: Text(
                _suggestedHabitList.length.toString() + " habits",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 40.0),
            ...List.generate(_suggestedHabitList.length, (index) {
              return Container(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 40.0),
                child: _suggestHabitCards[index],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _suggestHabitCard(
      int iconCode, String title, String subTitle, int color, int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.white24,
          ),
        ),
        onTap: () {
          Get.off(CreateHabitScreen(), arguments: _suggestedHabitList[index]);
        },
        leading: Container(
          child: Icon(
            IconData(iconCode, fontFamily: 'MaterialIcons'),
            size: 40.0,
            color: Color(color),
          ),
        ),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 25.0),
              ),
              SizedBox(height: 10.0),
              Text(subTitle),
            ],
          ),
        ),
        trailing: Container(
          child: IconButton(
            icon: Icon(
              Icons.info_sharp,
              size: 30.0,
              color: Color(0xFFF8B83B),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
