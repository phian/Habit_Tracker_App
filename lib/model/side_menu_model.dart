import 'package:flutter/cupertino.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

abstract class SideMenuModel {
  void openOrCloseSideMenu(GlobalKey<SideMenuState> key);
}
