import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';

ScrollController challengeTimelineController = ScrollController();
AnimateIconController aniController = AnimateIconController();

class ChallengeInfo {
  IconData icon;
  String title;
  String description;
  Color iconColor;

  ChallengeInfo({this.icon, this.title, this.description, this.iconColor});
}

/// [Social media]
var socialMediaChallengeInfos = [
  ChallengeInfo(
    icon: Icons.phone_android,
    title: "Cut down your screen time",
    description: "Keep track of time you spend on various apps",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.access_alarms,
    title: "Plan a healthy digital schedule",
    description: "This week aim spend two hours on your screen per day",
    iconColor: Color(0xFFFE7352),
  ),
  ChallengeInfo(
    icon: Icons.phone_android,
    title: "Delete unnecessary apps",
    description:
        "Cut down on the things that stand in the way of your best self",
    iconColor: Color(0xFF11C480),
  ),
];

/// [Bed routine]
var bedRoutineChallengeInfos = [
  ChallengeInfo(
    icon: Icons.dry_cleaning,
    title: "Prepare your clothes for the next day",
    description: "One thing less to do in the morning",
    iconColor: Color(0xFF11C480),
  ),
  ChallengeInfo(
    icon: Icons.event_outlined,
    title: "Make plan for tomorrow",
    description: "Stay organized and feel less stressed out",
    iconColor: Color(0xFFFE7352),
  ),
  ChallengeInfo(
    icon: Icons.event_outlined,
    title: "Make plan for tomorrow",
    description: "Stay organized and feel less stressed out",
    iconColor: Color(0xFFFE7352),
  ),
  ChallengeInfo(
    icon: Icons.event_outlined,
    title: "Make plan for tomorrow",
    description: "Stay organized and feel less stressed out",
    iconColor: Color(0xFFFE7352),
  ),
];

/// [Sugar-free]
var sugarFreeChallengeInfos = [
  ChallengeInfo(
    icon: Icons.cake,
    title: "Go sugar-free today",
    description: "Be mindful what you eat",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.cake,
    title: "Go sugar-free today",
    description: "Be mindful what you eat",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.cake,
    title: "Go sugar-free today",
    description: "Be mindful what you eat",
    iconColor: Color(0xFFFABB37),
  ),
];

/// [Intermittent fasting]
var intermittentFastingChallengeInfos = [
  ChallengeInfo(
    icon: Icons.local_dining,
    title: "Fast for 16 hours",
    description: "Consistency is the key",
    iconColor: Color(0xFF11C480),
  ),
  ChallengeInfo(
    icon: Icons.local_dining,
    title: "Fast for 16 hours",
    description: "Consistency is the key",
    iconColor: Color(0xFF11C480),
  ),
  ChallengeInfo(
    icon: Icons.local_dining,
    title: "Fast for 16 hours",
    description: "Consistency is the key",
    iconColor: Color(0xFF11C480),
  ),
];

/// [No alcohol]
var noAlcoholChallengeInfos = [
  ChallengeInfo(
    icon: Icons.local_bar_rounded,
    title: "No alcohol today",
    description: "Give the booze a little break",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.local_bar_rounded,
    title: "No alcohol today",
    description: "Give the booze a little break",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.local_bar_rounded,
    title: "No alcohol today",
    description: "Give the booze a little break",
    iconColor: Color(0xFFFABB37),
  ),
];

/// [Mindfulness]
var mindfulnessChallengeInfos = [
  ChallengeInfo(
    icon: Icons.accessibility_new_rounded,
    title: "Stretch it out",
    description: "Take a 10-minute break to relax",
    iconColor: Color(0xFFFE7352),
  ),
  ChallengeInfo(
    icon: Icons.money,
    title: "Make it in a \$0 day",
    description: "Do ot spend money for 24h",
    iconColor: Color(0xFF11C480),
  ),
  ChallengeInfo(
    icon: Icons.security,
    title: "Clean up the clutter",
    description: "Clean all the surfaces in your room",
    iconColor: Color(0xFF933DFF),
  ),
];

/// [Reationship]
var relationShipChallengeInfos = [
  ChallengeInfo(
    icon: Icons.favorite,
    title: "Give more hugs",
    description: "Sometimes a little squeeze is all it takes",
    iconColor: Color(0xFFF53566),
  ),
  ChallengeInfo(
    icon: Icons.mail,
    title: "Leave your partner a note",
    description: "Make them feel special",
    iconColor: Color(0xFFFABB37),
  ),
  ChallengeInfo(
    icon: Icons.local_pizza,
    title: "Have a romantic dinner",
    description: "Cook it yourself or just order a pizza",
    iconColor: Color(0xFFFE7352),
  ),
];

/// [Happy morning]
var happyMorningChallengeInfos = [
  ChallengeInfo(
    icon: Icons.local_drink_rounded,
    title: "Drink water when you wake up",
    description: "Start your day hydrated",
    iconColor: Color(0xFF1C8EFE),
  ),
  ChallengeInfo(
    icon: Icons.local_drink_rounded,
    title: "Drink water when you wake up",
    description: "Start your day hydrated",
    iconColor: Color(0xFF1C8EFE),
  ),
  ChallengeInfo(
    icon: Icons.local_drink_rounded,
    title: "Drink water when you wake up",
    description: "Start your day hydrated",
    iconColor: Color(0xFF1C8EFE),
  ),
  ChallengeInfo(
    icon: Icons.restaurant_menu_rounded,
    title: "Drink water when you wake up",
    description: "Start your day hydrated",
    iconColor: Color(0xFF11C480),
  ),
];
