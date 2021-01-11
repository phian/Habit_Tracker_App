import 'package:flutter/material.dart';

class MainScreenTreesAndCloud extends StatelessWidget {
  const MainScreenTreesAndCloud({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _cloudIcon(
          marginTop: 10.0,
          marginLeft: MediaQuery.of(context).size.width * 0.3,
          iconSize: 65.0,
          transformTop: -MediaQuery.of(context).size.height * 0.075,
        ),
        _cloudIcon(
          marginTop: MediaQuery.of(context).size.height * 0.09,
          marginLeft: MediaQuery.of(context).size.width * 0.8,
          iconSize: 80.0,
        ),
        _cloudIcon(
            marginTop: 30.0,
            marginLeft: 0.0,
            iconSize: 45.0,
            marginRight: MediaQuery.of(context).size.width * 0.3,
            transformTop: -MediaQuery.of(context).size.height * 0.07),
        _cloudIcon(
            marginTop: MediaQuery.of(context).size.height * 0.145,
            marginLeft: MediaQuery.of(context).size.width * 0.3,
            iconSize: 50.0,
            marginRight: MediaQuery.of(context).size.width * 0.3,
            transformTop: -MediaQuery.of(context).size.height * 0.07),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.25,
          20.0,
          80.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.275,
          70.0,
          60.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.33,
          MediaQuery.of(context).size.width * 0.8,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.374,
          MediaQuery.of(context).size.width * 0.9,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.38,
          MediaQuery.of(context).size.width * 0.75,
          50.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.6,
          MediaQuery.of(context).size.width * 0.1,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.68,
          MediaQuery.of(context).size.width * 0.15,
          50.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.62,
          MediaQuery.of(context).size.width * 0.2,
          80.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.63,
          MediaQuery.of(context).size.width * 0.02,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.62,
          MediaQuery.of(context).size.width * 0.75,
          90.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.66,
          MediaQuery.of(context).size.width * 0.66,
          70.0,
        ),
        _treeIcon(
          "images/tree1.png",
          MediaQuery.of(context).size.height * 0.73,
          MediaQuery.of(context).size.width * 0.75,
          50.0,
        ),
      ],
    );
  }

  Widget _cloudIcon({
    double marginTop,
    double marginLeft,
    double iconSize,
    double marginRight,
    double transformTop,
  }) {
    return Container(
      alignment: Alignment.topCenter,
      transform: transformTop != null
          ? Matrix4.translationValues(
              0.0,
              transformTop,
              0.0,
            )
          : null,
      margin: marginRight == null
          ? EdgeInsets.only(top: marginTop, left: marginLeft)
          : EdgeInsets.only(
              top: marginTop,
              right: marginRight,
              left: marginLeft,
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
