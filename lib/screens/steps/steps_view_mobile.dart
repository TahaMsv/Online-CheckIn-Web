import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:online_check_in/screens/steps/steps_controller.dart';
import 'package:online_check_in/screens/steps/steps_state.dart';
import 'package:online_check_in/screens/steps/widgets/bottom_of_page.dart';
import 'package:online_check_in/screens/steps/widgets/step_widget.dart';
import 'package:online_check_in/screens/steps/widgets/top_of_page.dart';
import '../../core/constants/ui.dart';
import 'package:online_check_in/initialize.dart';
import 'package:provider/provider.dart';

import '../../core/platform/device_info.dart';
import '../../widgets/MtDottedLine.dart';
import '../../widgets/MyDivider.dart';
import '../../widgets/my_drawer.dart';

class StepsView extends ConsumerStatefulWidget {
  StepsView({Key? key, required this.childWidget}) : super(key: key);
  final Widget childWidget;


  @override
  ConsumerState<StepsView> createState() => _StepsViewState();
}

class _StepsViewState extends ConsumerState<StepsView> {
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
    kBottomNavigationBarHeight;
    DeviceType deviceType = DeviceInfo.deviceType(context);

    return Scaffold(
      key: _scaffoldState,
      drawer: MyDrawer(),
      backgroundColor: theme.primaryColor,
      body: ListView(
        shrinkWrap: true,
        children: [
          TopOfPage(
            height: height,
            width: width,
            scaffoldState: _scaffoldState,
          ),
          SizedBox(
            width: width,
            height: height * 0.82,
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
                Container(
                    color: Colors.white,
                    height: height * 0.80 - 30,
                    padding: EdgeInsets.only(top: deviceType.isPhone ? 10 : 30, left: deviceType.isPhone ? 10 : 30, right: deviceType.isPhone ? 10 : 30),
                    child: widget.childWidget),
              ],
            ),
          ),
          BottomOfPage(height: height, stepsController: stepsController),
        ],
      ),
    );
  }
}
