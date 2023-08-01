import 'package:flutter/material.dart';

import 'package:online_check_in/initialize.dart';
import '../screens/login/login_controller.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = getIt<LoginController>();

    return Container(
      // height: 120,
      width: 150,
      margin: EdgeInsets.only(left:20, top: 80),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Colors.white,

            child: ListTile(
              title: const Text('Home'),
              onTap: () {
                loginController.goToHome();
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: const Text('Change Station'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
        ],
      ),
    );
  }
}
