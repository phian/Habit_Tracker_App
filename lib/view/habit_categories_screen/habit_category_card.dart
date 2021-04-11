import 'package:flutter/material.dart';

class HabitCateGoryCard extends StatelessWidget {
  final String title, subtitle, imagePath;
  HabitCateGoryCard({this.title, this.subtitle, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0),
                width: 220.0,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5.0, top: 5.0),
                width: 200.0,
                child: Text(
                  subtitle,
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFF9A9DA4),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
