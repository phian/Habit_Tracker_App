import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/manage_screen.dart';
import 'package:page_transition/page_transition.dart';

class HabitCategoriesScreen extends StatefulWidget {
  HabitCategoriesScreen({Key key}) : super(key: key);

  @override
  _HabitCategoriesScreenState createState() => _HabitCategoriesScreenState();
}

class _HabitCategoriesScreenState extends State<HabitCategoriesScreen> {
  AnimateIconController controller;

  List<String> habitCategoryTitles;
  List<String> habitCategorySubTitles;
  List<String> habitCategoryImagePaths;
  List<Widget> habitCategoryCards;

  List<Widget> createYourOwnCards;

  @override
  void initState() {
    super.initState();
    initCategoriesCardInfo();
    generateHitCateGoryCards();
    generateCreateYourOwnCards();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF368B8B),
        appBar: habitCategoriesAppBar(),
        body: habitCateGoriesBody(),
      ),
    );
  }

//====================================================================//

  // Appbar
  Widget habitCategoriesAppBar() {
    return AppBar(
      leading: Container(
        transform: Matrix4.translationValues(-3.0, -4.0, 0.0),
        child: IconButton(
          icon: AnimateIcons(
            startIcon: Icons.arrow_back,
            endIcon: Icons.menu_rounded,
            size: 35.0,
            controller: controller,
            startTooltip: '',
            endTooltip: '',
            onStartIconPress: () {
              Future.delayed(
                Duration(milliseconds: 200),
                () {
                  Navigator.of(context).push(
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 500),
                      child: ManageScreen(),
                    ),
                  );
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
            fontFamily: "RobotoSlab",
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }
  //====================================================================//

  // Body
  Widget habitCateGoriesBody() {
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
              fontFamily: "RobotoSlab",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          createYourOwnCards[0],
          SizedBox(
            height: 20.0,
          ),
          createYourOwnCards[1],
          SizedBox(
            height: 30.0,
          ),
          Text(
            "Or choose in these categories",
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "RobotoSlab",
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          ...List.generate(
              habitCategoryTitles.length,
              (index) => Container(
                    margin: index == 0
                        ? null
                        : EdgeInsets.only(
                            top: 15.0,
                          ),
                    child: habitCategoryCards[index],
                  )),
        ],
      ),
    );
  }

  void initCategoriesCardInfo() {
    habitCategoryTitles = [
      "Trending habits",
      "Staying at home",
      "Preventive care",
      "Must-have habits",
      "Morning routine",
      "Nighttime rituals",
      "Getting stuff done",
      "Healthy body",
      "Stress relief",
      "Mindful-self care",
      "Learn and explore",
      "Staying fit",
      "Personal finance",
      "Loved ones",
      "Around the house",
      "Tracking the diet",
      "Live with hobbies",
      "Remove bad habits"
    ];

    habitCategorySubTitles = [
      "Take a step in a right direction",
      "Use this time to do something new",
      "Protect yourself and others",
      "Small efforts, big results",
      "Get started on a productive day",
      "Sleep tight for better health",
      "Boost your every day productivity",
      "The foundation of your health well-being",
      "Release tension and increase and increase calm",
      "Take care with daily activities",
      "Expand your knowledge",
      "Feel strong and increase enrgy",
      "Take control of your budget",
      "Nature inportant relationships",
      "Clean your space and your mind",
      "Keep your tidy body",
      "Spend this time to do what you like",
      "Make your life better",
    ];

    habitCategoryImagePaths = [
      "images/trending_habits.png",
      "images/at_home.png",
      "images/preventive_care.png",
      "images/must_have_habit.png",
      "images/morning_routine.png",
      "images/nighttime_rituals.png",
      "images/getting_stuff_done.png",
      "images/healthy_body.png",
      "images/stress_relief.png",
      "images/self_care.png",
      "images/learn_and_explore.png",
      "images/staying_fit.png",
      "images/personal_finance.png",
      "images/loved_ones.png",
      "images/around_the_house.png",
      "images/tracking_the_diet.png",
      "images/live_with_hobbies.png",
      "images/bad_habit.png",
    ];

    habitCategoryCards = new List<Widget>();
    createYourOwnCards = new List<Widget>();
  }

  Widget createYourOwnCard(IconData icon, Color iconColor, String title) {
    return Container(
      padding: EdgeInsets.only(left: 30.0),
      height: 80.0,
      decoration: BoxDecoration(
          color: Color(0xFF252D42),
          borderRadius: BorderRadius.circular(
            20.0,
          )),
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
                fontFamily: "RobotoSlab",
              ),
            ),
          ),
        ],
      ),
    );
  }

  void generateCreateYourOwnCards() {
    for (int i = 0; i < 2; i++) {
      i == 0
          ? createYourOwnCards.add(createYourOwnCard(
              Icons.calendar_today_rounded, Color(0xFF178EFA), "Regular habit"))
          : createYourOwnCards.add(createYourOwnCard(
              Icons.today_rounded, Color(0xFFFE6F4C), "One-time task"));
    }
  }

  Widget habitCateGoryCard(String title, String subtitle, String imagePath) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF252D42),
          borderRadius: BorderRadius.circular(
            20.0,
          )),
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
                    fontFamily: "RobotoSlab",
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
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "RobotoSlab",
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

  void generateHitCateGoryCards() {
    for (int i = 0; i < habitCategoryTitles.length; i++) {
      habitCategoryCards.add(habitCateGoryCard(habitCategoryTitles[i],
          habitCategorySubTitles[i], habitCategoryImagePaths[i]));
    }
  }
}
