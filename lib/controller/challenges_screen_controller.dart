import 'package:get/get.dart';
import 'package:habit_tracker/constants/app_images.dart';

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
      AppImages.imgSocialMediaChallenge,
      AppImages.imgBedTimeRoutineChallenge,
      AppImages.imgSugarFreeChallenge,
      AppImages.imgIntermittentFastingChallenge,
      AppImages.imgNoAlcoholChallenge,
      AppImages.imgMindfulnessChallenge,
      AppImages.imgRelationshipChallenge,
      AppImages.imgMorningChallenge,
    ];
    super.onInit();
  }
  
}
