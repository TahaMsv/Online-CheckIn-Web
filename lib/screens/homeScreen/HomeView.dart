import 'package:flutter/material.dart';
import '../../global/MainModel.dart';
import '../../utility/Constants.dart';
import 'HomeController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  final HomeController myHomeController;
  HomeView(MainModel model) : myHomeController = Get.put(HomeController(model));
  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    ThemeData theme = Theme.of(context);
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        children: [
          TextField(controller: myHomeController.nameC,),
          TextButton(onPressed: (){
            print(myHomeController.nameC.text);
          }, child: Text("Report")),
          TextButton(onPressed: (){
            myHomeController.nameC.clear();
          }, child: Text("Clean")),
          TextButton(onPressed: (){
            myHomeController.nameC.text="Edti";
          }, child: Text("Edit")),
        ],
      ),
    );
  }
}
