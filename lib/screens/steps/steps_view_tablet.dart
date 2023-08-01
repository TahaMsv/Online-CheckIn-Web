import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/screens/steps/widgets/bottom_of_page.dart';
import 'package:online_check_in/screens/steps/widgets/step_widget.dart';
import 'package:online_check_in/screens/steps/widgets/top_of_page.dart';
import 'package:online_check_in/widgets/MyDivider.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../widgets/LanguagePicker.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyElevatedButton.dart';
import '../../widgets/my_drawer.dart';

class StepsViewTablet extends ConsumerStatefulWidget {
  StepsViewTablet({Key? key, required this.childWidget}) : super(key: key);
  final Widget childWidget;

  @override
  ConsumerState<StepsViewTablet> createState() => _StepsViewTabletState();
}

class _StepsViewTabletState extends ConsumerState<StepsViewTablet> {
  final StepsController stepsController = getIt<StepsController>();
  late GlobalKey<ScaffoldState> _scaffoldState;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _scaffoldState = GlobalKey<ScaffoldState>();
  }
  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    StepsState stepsState = ref.watch(stepsProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldState,
      drawer: MyDrawer(),
      backgroundColor: theme.primaryColor,
      body: stepsState.stepLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                TopOfPage(height: height, width: width, scaffoldState: _scaffoldState,),
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
                            stepsController.stepsToShowList().map((i) => StepWidget(index: i)).toList() +
                            [
                              const Expanded(
                                child: MyDivider(),
                              ),
                            ],
                      ),
                      Container(color: Colors.white, height: height * 0.80 - 30, padding: const EdgeInsets.only(top: 50, left: 30, right: 30), child: widget.childWidget),
                    ],
                  ),
                ),
                BottomOfPage(height: height, stepsController: stepsController),
              ],
            ),
    );
  }
}
