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
      "${AppConstants.imagePath}social_media_challenge.png",
      "${AppConstants.imagePath}bedtime_routine_challenge.png",
      "${AppConstants.imagePath}sugar_free_challenge.png",
      "${AppConstants.imagePath}intermittent_fasting_challenge.png",
      "${AppConstants.imagePath}no_alcohol_challenge.png",
      "${AppConstants.imagePath}mindfulness_challenge.png",
      "${AppConstants.imagePath}relationship_challenge.png",
      "${AppConstants.imagePath}morning_challenge.png",
    ];
    super.onInit();
  }
  
}
