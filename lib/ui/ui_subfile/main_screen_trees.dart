import 'package:flutter/material.dart';

class MainScreenTreesAndCloud extends StatelessWidget {
  const MainScreenTreesAndCloud({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _cloudIcon(
          10.0,
          MediaQuery.of(context).size.width * 0.3,
          50.0,
        ),
        _cloudIcon(
          MediaQuery.of(context).size.height * 0.18,
          MediaQuery.of(context).size.width * 0.8,
          80.0,
        ),
        _cloudIcon(
          30.0,
          0,
          40.0,
          MediaQuery.of(context).size.width * 0.3,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.3,
          20.0,
          80.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.325,
          70.0,
          60.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.38,
          MediaQuery.of(context).size.width * 0.8,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.424,
          MediaQuery.of(context).size.width * 0.9,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.43,
          MediaQuery.of(context).size.width * 0.75,
          50.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.72,
          MediaQuery.of(context).size.width * 0.1,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.8,
          MediaQuery.of(context).size.width * 0.15,
          50.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.74,
          MediaQuery.of(context).size.width * 0.2,
          80.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.75,
          MediaQuery.of(context).size.width * 0.02,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.68,
          MediaQuery.of(context).size.width * 0.75,
          90.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.72,
          MediaQuery.of(context).size.width * 0.66,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.79,
          MediaQuery.of(context).size.width * 0.75,
          50.0,
        ),
      ],
    );
  }

  Widget _cloudIcon(double marginTop, double marginLeft, double iconSize,
      [double marginRight]) {
    return Container(
      alignment: Alignment.topCenter,
      margin: marginRight == null
          ? EdgeInsets.only(top: marginTop, left: marginLeft)
          : EdgeInsets.only(
              top: marginTop,
              right: marginRight,
            ),
      child: Icon(
        Icons.cloud,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }

  Widget _treeIcon(
      String imagePath, double marginTop, double marginLeft, double imageSize,
      [double marginRight]) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight != null ? marginRight : 0.0,
      ),
      child: Image.asset(
        imagePath,
        width: imageSize,
        height: imageSize,
      ),
    );
  }
}
