import 'package:flutter/cupertino.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class SideMenuModel {
  void openOrCloseSideMenu({GlobalKey<SideMenuState> sideMenuKey}) {
    if (sideMenuKey.currentState.isOpened)
      sideMenuKey.currentState.closeSideMenu();
    else
      sideMenuKey.currentState.openSideMenu();
  }
}