import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_controller.dart';
import 'package:online_checkin_web_refactoring/screens/steps/steps_state.dart';
import 'package:online_checkin_web_refactoring/screens/steps/widgets/bottom_of_page.dart';
import 'package:online_checkin_web_refactoring/screens/steps/widgets/step_widget.dart';
import 'package:online_checkin_web_refactoring/screens/steps/widgets/top_of_page.dart';
import 'package:online_checkin_web_refactoring/widgets/MyDivider.dart';
import '../../core/constants/ui.dart';
import '../../core/dependency_injection.dart';
import 'package:provider/provider.dart';

import '../../widgets/LanguagePicker.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';

class StepsViewTablet extends StatelessWidget {
  StepsViewTablet({Key? key, required this.childWidget}) : super(key: key);
  final StepsController stepsController = getIt<StepsController>();
  final Widget childWidget;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = context.watch<StepsState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: stepsState.stepLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                TopOfPage(
                  height: height,
                  width: width,
                  stepsController: stepsController,
                  isTabletMode: true,
                ),
                SizedBox(
                  width: width,
                  height: height * 0.81,
                  // color: Colors.green,
                  child: ListView(
                    children: [
                      Row(
                        children: <Widget>[
                              Expanded(
                                child: stepsState.step == 0
                                    ? const MyDottedLine(
                                        lineLength: double.infinity,
                                        color: MyColors.oceanGreen,
                                      )
                                    : Container(
                                        height: 1,
                                        color: MyColors.oceanGreen,
                                      ),
                              ),
                            ] +
                            stepsController
                                .stepsToShowList()
                                .map((i) => StepWidget(
                                      index: i,
                                      isTabletMode: true,
                                    ))
                                .toList() +
                            [
                              const Expanded(
                                child: MyDivider(),
                              ),
                            ],
                      ),
                      Container(color: Colors.white, height: height * 0.80 - 30, padding: const EdgeInsets.only(top: 50, left: 30, right: 30), child: childWidget),
                    ],
                  ),
                ),
                BottomOfPage(height: height, stepsController: stepsController, isTabletMode: true),
              ],
            ),
    );
  }
}
