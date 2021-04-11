import 'package:get/get.dart';
import 'file:///D:/DDisk/source/Android_DoAnFlutterJava/habit_tracker/lib/view/challenge_timeline_screen/challenge_time_line_screen_variables.dart';

class ChallengeTimelineScreenController extends GetxController {
  List<ChallengeInfo> challengeList = [];
  List<String> dateNamesList = [];

  void initChallengeTimelineScreenData(int tag) {
    initChallengeData(tag);
    initDateName();
  }

  void initChallengeData(int tag) {
    switch (tag) {
      case 0:
      case 8:
        challengeList = happyMorningChallengeInfos;
        break;
      case 1:
        challengeList = socialMediaChallengeInfos;
        break;
      case 2:
        challengeList = bedRoutineChallengeInfos;
        break;
      case 3:
        challengeList = sugarFreeChallengeInfos;
        break;
      case 4:
        challengeList = intermittentFastingChallengeInfos;
        break;
      case 5:
        challengeList = noAlcoholChallengeInfos;
        break;
      case 6:
        challengeList = mindfulnessChallengeInfos;
        break;
      case 7:
        challengeList = relationShipChallengeInfos;
        break;
    }
  }

  void initDateName() {
    for (int i = 0; i <= challengeList.length; i++) {
      var date = DateTime.now().add(Duration(days: i));

      switch (date.weekday) {
        case 1:
          dateNamesList.add("Mon");
          break;
        case 2:
          dateNamesList.add("Tue");
          break;
        case 3:
          dateNamesList.add("Wed");
          break;
        case 4:
          dateNamesList.add("Thu");
          break;
        case 5:
          dateNamesList.add("Fri");
          break;
        case 6:
          dateNamesList.add("Sat");
          break;
        case 7:
          dateNamesList.add("Sun");
          break;
      }
    }
  }
}
