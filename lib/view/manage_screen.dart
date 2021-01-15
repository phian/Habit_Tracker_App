import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/manage_screen_controller.dart';
import 'habit_categories_screen.dart';

class ManageScreen extends StatelessWidget {
  var _controller = Get.put(ManageScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E212A),
      body: Obx(() => _controller.screens[_controller.currentIndex.value]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(HabitCategoriesScreen(), transition: Transition.fadeIn);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.black12,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          height: 56,
          child: Row(
            children: <Widget>[
              ...List.generate(
                _controller.iconList.length,
                (index) => Obx(
                  () => _bottomBarButton(
                    _controller.iconList[index],
                    index,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomBarButton(IconData icon, int index) {
    return Container(
      padding: index == 0
          ? EdgeInsets.only(left: Get.width * 0.05)
          : EdgeInsets.only(left: Get.width * 0.09),
      child: IconButton(
        icon: Icon(
          icon,
          color: _controller.currentIndex.value == index
              ? Colors.blue
              : Colors.grey,
          size: 30.0,
        ),
        onPressed: () {
          _controller.changeScreen(RxInt(index));
        },
      ),
    );
  }
}
