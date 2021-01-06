import 'package:flutter/material.dart';

class AllHabitsScreen extends StatefulWidget {
  AllHabitsScreen({Key key}) : super(key: key);

  @override
  _AllHabitsScreenState createState() => _AllHabitsScreenState();
}

class _AllHabitsScreenState extends State<AllHabitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF368B8B),
      child: Center(
        child: Text("All Habits Screen"),
      ),
    );
  }
}
