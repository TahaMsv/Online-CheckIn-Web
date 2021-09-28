import 'package:flutter/material.dart';
import '../../global/MainModel.dart';
import 'SplashController.dart';
import '../../utility/Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  final SplashController mySplashController;
  SplashView(MainModel model) : mySplashController =  Get.put(SplashController(model));
  @override
  Widget build(BuildContext context) {
    MainModel model = context.watch<MainModel>();
    ThemeData theme = Theme.of(context);
    double width = Get.width;
    double height = Get.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Splash"),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Get.toNamed(RouteNames.home);
              }),
          IconButton(
              icon: Icon(Icons.color_lens),
              onPressed: () {
                Get.changeTheme(Get.isDarkMode ? MyTheme.light : MyTheme.dark);
              })
        ],
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                model.setLoading(!model.loading);
              },
              child: Row(
                children: [
                  Text("Global Loading"),
                  Center(child: model.loading ? SpinKitCircle(color: theme.accentColor) : Container()),
                ],
              )),
          TextButton(
              onPressed: () {
                mySplashController.loadingSplash.toggle();
              },
              child: Row(
                children: [
                  Text("Splash Loading"),
                  Obx(() => Center(
                      child: mySplashController.loadingSplash.value ? SpinKitCircle(color: theme.accentColor) : Container())),
                ],
              )),
        ],
      ),
    );
  }
}
