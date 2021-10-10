import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../screens/passportStepScreen/PassportStepController.dart';
import '../../screens/rulesStepScreen/RulesStepController.dart';
import '../../global/MainModel.dart';
import 'package:get/get.dart';

class PassportStepView extends StatelessWidget {
  final PassportStepController myPassportStepController;

  PassportStepView(MainModel model)
      : myPassportStepController = Get.put(PassportStepController(model));

  @override
  Widget build(BuildContext context) {
    // double width = Get.width;
    // double height = Get.height;

    var travellers = [
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
      {
        "name": "Mr. Jack Taylor",
        "isComplete": false,
      },
      {
        "name": "Ms. Ana Lee",
        "isComplete": true,
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Passport",
                style: TextStyle(
                    color: Color(0xff424242),
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Enter passport data (DOCS) for all the passengers.",
                style: TextStyle(
                    color: Color(0xff424242),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              // crossAxisSpacing: 60,
              childAspectRatio: 315 / 193,
              children: travellers.map(
                (value) {
                  return InfoCard(
                    info: value,
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  final dynamic info;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    Color bgColor;
    if (info["isComplete"]) {
      textColor = Color(0xffffffff);
      bgColor = Color(0xff48c0a2);
    } else {
      textColor = Color(0xff424242);
      bgColor = Color(0xffffffff);
    }
    return Container(
      // height: 300,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      width: 315,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: Color(0xffeaeaea),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.warning_amber_sharp,
                color: info["isComplete"]
                    ? Colors.white.withOpacity(0)
                    : Color(0xfff86f6f),
                size: 20,
              )
            ],
          ),
          Text(
            info['name'],
            style: TextStyle(
              color: textColor,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            children: [
              Text(
                "ID: ",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "45678",
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          info["isComplete"] ? EditIPassInfo() : AddPassInfo(),
        ],
      ),
    );
  }
}

class AddPassInfo extends StatelessWidget {
  const AddPassInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.add_circle_outline_rounded,
          color: Color(0xff4d6fff),
          size: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "Add Passport Info",
          style: TextStyle(
            color: Color(0xff4d6fff),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class EditIPassInfo extends StatelessWidget {
  const EditIPassInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.check,
              color: Color(0xffffffff),
              size: 18,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Passport No: 43657",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Icon(
          Icons.edit,
          color: Colors.white,
          size: 18,
        )
      ],
    );
  }
}
