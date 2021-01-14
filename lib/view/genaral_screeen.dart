import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/gernaral_screen_controller.dart';

class GeneralScreen extends StatelessWidget {
  GeneralScreenController _generalScreenController = GeneralScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      appBar: _generalScreenAppBar(),
      body: ListView(
        padding: EdgeInsets.only(top: 40.0),
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          _genralScreenItem(
            icon: Icons.brightness_7,
            title: 'Time of day',
            iconColor: Color(0xFFFABB37),
          ),
          Container(
            height: 1,
            color: Colors.white24,
          ),
          _genralScreenItem(
            icon: Icons.calendar_today,
            title: 'Start week on',
            iconColor: Color(0xFFFE7352),
          ),
          SizedBox(height: 50.0),
          _genralScreenItem(
            icon: Icons.badge,
            title: 'Icon badge',
            iconColor: Color(0xFF11C480),
            isSwitch: true,
            toggle: _generalScreenController.isOcIconBadge,
          ),
          Container(
            padding: EdgeInsets.only(left: 17.0, top: 5.0, right: 17.0),
            child: Text(
              "See how many habits are due for current part of day",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          SizedBox(height: 50.0),
          _genralScreenItem(
            icon: Icons.phone_android,
            title: 'Minimalist Interface',
            iconColor: Color(0xFF1C8EFE),
            isSwitch: true,
            toggle: _generalScreenController.isMinimalistInterface,
          ),
          Container(
            padding: EdgeInsets.only(left: 17.0, top: 5.0, right: 17.0),
            child: Text(
              "Hide animation from the main screen and remove sloth",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          SizedBox(height: 50.0),
          _genralScreenItem(
            icon: Icons.beach_access,
            title: 'Vacation mode',
            iconColor: Color(0xFF1C8EFE),
            isSwitch: true,
            toggle: _generalScreenController.isVacationMode,
          ),
          Container(
            padding: EdgeInsets.only(left: 17.0, top: 5.0, right: 17.0),
            child: Text(
              "Enable vacation mode to pause all your habits and keep your stats",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          SizedBox(height: 50.0),
          _genralScreenItem(
            icon: Icons.straighten,
            title: 'Units of Measure',
            iconColor: Color(0xFF1C8EFE),
          ),
          Container(
            height: 1,
            color: Colors.white24,
          ),
          _genralScreenItem(
            icon: Icons.volume_down,
            title: 'Sounds',
            iconColor: Color(0xFF1C8EFE),
            isSwitch: true,
            toggle: _generalScreenController.isOnSound,
          ),
          Container(
            height: 1,
            color: Colors.white24,
          ),
          _genralScreenItem(
            icon: Icons.music_note,
            title: 'Notification tone',
            iconColor: Color(0xFF1C8EFE),
          ),
          Container(
            height: 1,
            color: Colors.white24,
          ),
          _genralScreenItem(
            icon: Icons.lock_rounded,
            title: 'Passcode lock',
            iconColor: Color(0xFF1C8EFE),
            isSwitch: true,
            toggle: _generalScreenController.isPassCodeLock,
          ),
          Container(
            height: 1,
            color: Colors.white24,
          ),
          _genralScreenItem(
            icon: Icons.delete_forever,
            title: 'Clean Slate Protocol',
            iconColor: Color(0xFF1C8EFE),
          ),
          SizedBox(height: 40.0),
          _genralScreenItem(
            icon: Icons.build,
            title: 'Export Data',
            iconColor: Color(0xFF1C8EFE),
          ),
        ],
      ),
    );
  }

  /// [App Bar]
  Widget _generalScreenAppBar() {
    return AppBar(
      title: Text(
        "General",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black12,
      centerTitle: true,
      elevation: 0.0,
    );
  }

  /// [Wiget hiển thị các item]
  Widget _genralScreenItem({
    IconData icon,
    Color iconColor,
    String title,
    bool isSwitch,
    RxBool toggle,
  }) {
    return Container(
      alignment: Alignment.center,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: Color(0xFF2F313E),
      ),
      child: ListTile(
        onTap: () {
          _changeSwitchData(title);
        },
        leading: Icon(
          icon,
          color: iconColor,
          size: 30.0,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 25.0),
        ),
        trailing: isSwitch == null
            ? Icon(Icons.keyboard_arrow_right_outlined)
            : Obx(
                () => Switch(
                  value: toggle.value,
                  onChanged: (value) {
                    _changeSwitchData(title);
                  },
                ),
              ),
      ),
    );
  }

  void _changeSwitchData(String title) {
    switch (title.toLowerCase()) {
      case 'icon badge':
        _generalScreenController.onOrOffSwitch(0);
        break;
      case 'minimalist interface':
        _generalScreenController.onOrOffSwitch(1);
        break;
      case 'vacation mode':
        _generalScreenController.onOrOffSwitch(2);
        break;
      case 'sounds':
        _generalScreenController.onOrOffSwitch(3);
        break;
      case 'passcode lock':
        _generalScreenController.onOrOffSwitch(4);
        break;
    }
  }
}
