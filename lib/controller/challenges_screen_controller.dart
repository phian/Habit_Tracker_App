import 'package:get/get.dart';
import 'package:habit_tracker/model/side_menu_model.dart';
import 'package:habit_tracker/view/challenge_time_line_screen.dart';

class ChallengesScreenController extends GetxController with SideMenuModel {
  List<String> challengeTitles, challengeAmounts, imagePaths;

  void initData() {
    challengeTitles = [
      "Social Media Detox Challenge",
      "Bedtime Routine Challenge",
      "Sugar Free Challenge",
      "Intermittent Fasting Challenge",
      "No Alcohol Challenge",
      "Mindfulness Challenge",
      "Relationship Challenge",
      "Happy Morning Chalenge",
    ];
    challengeAmounts = [
      "776",
      "443",
      "313",
      "201",
      "215",
      "412",
      "228",
      "10355",
    ];
    imagePaths = [
      "images/social_media_challenge.png",
      "images/bedtime_routine_challenge.png",
      "images/sugar_free_challenge.png",
      "images/intermittent_fasting_challenge.png",
      "images/no_alcohol_challenge.png",
      "images/mindfulness_chllenge.png",
      "images/relationship_challenge.png",
      "images/morning_challenge.png",
    ];
  }

  void moveToChallengeScreen({
    int tag,
    String title,
    String challengeAmount,
    String imagePath,
  }) {
    Get.to(
      ChallengeTimeLineScreen(
        tag: tag,
        title: title,
        challengeAmount: challengeAmount,
        imagePath: imagePath,
      ),
    );
  }
}
