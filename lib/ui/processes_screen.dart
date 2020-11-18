import 'package:flutter/material.dart';

class ProcessesScreen extends StatefulWidget {
  ProcessesScreen({Key key}) : super(key: key);

  @override
  _ProcessesScreenState createState() => _ProcessesScreenState();
}

class _ProcessesScreenState extends State<ProcessesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Processes Screen"),
      ),
    );
  }
}
