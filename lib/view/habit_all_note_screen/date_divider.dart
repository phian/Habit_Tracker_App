import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String date;
  DateDivider({this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.white24,
              ),
            ),
          ),
          Text(
            this.date,
            style: TextStyle(fontSize: 20.0),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Divider(
                thickness: 0.5,
                color: Colors.white24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
