import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  ChallengesScreen({Key key}) : super(key: key);

  @override
  _ChallengesScreenState createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF368B8B),
      body: Container(
        child: Text("Challenges Screen"),
        alignment: Alignment.center,
      ),
    );
  }
}
