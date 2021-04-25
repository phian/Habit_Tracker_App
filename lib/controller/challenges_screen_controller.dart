import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_constant.dart';

class ChallengesScreenController extends GetxController {
  List<String> challengeTitles, challengeAmounts, imagePaths;
  @override
  void onInit() {
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
      "${AppConstant.imagePath}social_media_challenge.png",
      "${AppConstant.imagePath}bedtime_routine_challenge.png",
      "${AppConstant.imagePath}sugar_free_challenge.png",
      "${AppConstant.imagePath}intermittent_fasting_challenge.png",
      "${AppConstant.imagePath}no_alcohol_challenge.png",
      "${AppConstant.imagePath}mindfulness_chllenge.png",
      "${AppConstant.imagePath}relationship_challenge.png",
      "${AppConstant.imagePath}morning_challenge.png",
    ];
    super.onInit();
  }
  
}
