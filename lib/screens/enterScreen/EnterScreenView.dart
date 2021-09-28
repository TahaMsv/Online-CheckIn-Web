import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/enterScreen/EnterScreenController.dart';
import '../../global/MainModel.dart';
import '../../utility/Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EnterScreenView extends StatelessWidget {
  final EnterScreenController myEnterScreenController;

  EnterScreenView(MainModel model)
      : myEnterScreenController = Get.put(EnterScreenController(model));

  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    // double width = Get.width;
    // double height = Get.height;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.blue,
      // ),
      body: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackgroundImage(width: width, height: height),
            LeftSide(),
            Positioned(
                top: 25,
                right: 30,
                child: Container(
                  height: 710,
                  width: 400,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: width,
        height: height,
        child: Image.asset(
          'assets/images/abomis-bg.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 50,
      child: Container(
        color: Colors.black.withOpacity(0),
        height: 295,
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ready to go?",
                    style: TextStyle(
                        fontSize: 23,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "There are a few things to know before boarding.",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 48, bottom: 16, left: 5),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.fact_check_outlined,
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(right: 15),
                  ),
                  Text(
                    "When can I check in?",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 42, left: 5),
              child: Text(
                "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.",
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: ElevatedButton(
                      onPressed: null,
                      child: Row(
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 18),
                            child: Text(
                              "Previous",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    margin: EdgeInsets.only(right: 85),
                  ),
                  ElevatedButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 18),
                          child: Text(
                            "Next",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
