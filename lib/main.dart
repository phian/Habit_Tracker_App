import 'package:flutter/material.dart';
import 'package:habit_tracker/ui/main_screen.dart';
import 'package:habit_tracker/ui/manage_screen.dart';

void main() => runApp(MaterialApp(
      home: IntroScreen(),
      debugShowCheckedModeBanner: false,
    ));

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ManageScreen(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Scaffold(
          body: Center(child: Text("Intro Screen")),
        ),
      ),
    );
  }
}
