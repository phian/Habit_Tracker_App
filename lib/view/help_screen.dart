import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_color.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFF37,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Container(
        child: Text(
          "Help",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.cFF1E,
      elevation: 0.0,
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      physics: BouncingScrollPhysics(),
      children: [
        _buildHeaderList().marginOnly(top: 24.0),
        _buildInstruction(),
      ],
    );
  }

  Widget _buildHeaderList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _headerListWidget(title: "Rate App", icon: Icons.stars),
        _buildDividerWidget(),
        _headerListWidget(title: "Contact Us", icon: Icons.contact_mail),
        _buildDividerWidget(),
        _headerListWidget(title: "Tell Friends", icon: Icons.ios_share),
      ],
    );
  }

  Widget _headerListWidget({required String title, required IconData icon}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 40.0,
        ).marginOnly(bottom: 12.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildDividerWidget() {
    return Container(
      height: 67,
      width: 0.5,
      color: AppColors.cFF9E,
    );
  }

  Widget _buildInstruction() {
    return Container(
      margin: EdgeInsets.only(top: 24.0),
      padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      decoration: BoxDecoration(
          color: AppColors.cFF1E, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "INSTRUCTION",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
              color: AppColors.c1FFF,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_forward),
                  decoration: BoxDecoration(
                    color: AppColors.cFF11,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "Swipe right for done",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
              color: AppColors.c1FFF,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Swipe right for done",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_back),
                  decoration: BoxDecoration(
                    color: AppColors.cFF3A,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: BoxDecoration(
              color: AppColors.c1FFF,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Icon(
                    Icons.touch_app_outlined,
                    color: AppColors.cFFFA,
                    size: 35.0,
                  ),
                ),
                Text(
                  "Swipe right for done",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ).marginOnly(left: 8.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
