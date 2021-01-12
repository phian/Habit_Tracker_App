import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/controller/all_habit_controller.dart';

class AllHabitsScreen extends StatelessWidget {
  AllHabitController allHabitController = Get.put(AllHabitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'All habit',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'RobotoSlab',
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff1B1B1B),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xff292929),
        child: Obx(() => listAllHabit()),
      ),
    );
  }

  Widget listAllHabit() {
    return ListView.separated(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      itemCount: allHabitController.listAllHabit.length,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 10),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Color(0xff333333),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  IconData(allHabitController.listAllHabit[index].icon,
                      fontFamily: 'MaterialIcons'),
                  size: 50,
                  color: Color(
                    int.parse(
                      allHabitController.listAllHabit[index].mau,
                      radix: 16,
                    ),
                  ),
                ),
              ),
              Text(
                allHabitController.listAllHabit[index].ten,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'RobotoSlab',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
